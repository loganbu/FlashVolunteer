class Neighborhood < ActiveRecord::Base  
    reverse_geocoded_by :latitude, :longitude

    def events
        return Event.where(:neighborhood_id => self.id)
    end
end
