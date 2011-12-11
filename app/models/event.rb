class Event < ActiveRecord::Base
    belongs_to :neighborhood, :foreign_key => "Neighborhood_id"
end
