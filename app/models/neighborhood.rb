class Neighborhood < ActiveRecord::Base  
    reverse_geocoded_by :latitude, :longitude

    def participations
		participations_source.includes(:participations).map(&:participations).flatten
    end

    def volunteer_hours
    	participations.map{|p| p.hours_volunteered == nil ? 0 : p.hours_volunteered}.inject(0,:+)
    end

    def volunteers
    	participations.map(&:user)
    end

    def score
    	if User.in_neighborhood(self).count == 0
    		0
    	else
	    	(volunteers.count/User.in_neighborhood(self).count)*volunteer_hours
	    end
    end

    def allstar
    	User.in_neighborhood(self).sort_by(&:score).reverse.first
    end

    def participations_source
        return User.in_neighborhood(self)
    end

    def events
        return Event.where(:neighborhood_id => self.id)
    end
end
