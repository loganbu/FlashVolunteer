class Neighborhood < ActiveRecord::Base  
    reverse_geocoded_by :latitude, :longitude

    def participations(focus)
		participations_source(focus).includes(:participations).map(&:participations).flatten
    end

    def volunteer_hours(focus)
    	participations(focus).map{|p| p.hours_volunteered == nil ? 0 : p.hours_volunteered}.inject(0,:+)
    end

    def volunteers(focus)
    	participations(focus).map(&:user)
    end

    def score(focus)
    	if User.in_neighborhood(self).count == 0
    		0
    	else
	    	(volunteers(focus).count/User.in_neighborhood(self).count)*volunteer_hours(focus)
	    end
    end

    def allstar
    	User.in_neighborhood(self).sort_by(&:score).reverse.first
    end

    def participations_source(focus)
        if (focus == "event")
            return events
        else
            return User.where(:neighborhood_id => self.id)
        end
    end

    def score_event
        score("event")
    end

    def score_user
        score("user")
    end

    def events
        return Event.where(:neighborhood_id => self.id)
    end
end
