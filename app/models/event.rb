class Event < ActiveRecord::Base
    belongs_to :neighborhood, :foreign_key => "Neighborhood_id"
    belongs_to :user, :foreign_key => "creator_id"
end
