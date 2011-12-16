class Event < ActiveRecord::Base
  belongs_to :neighborhood, :foreign_key => "neighborhood_id"
  belongs_to :user, :foreign_key => "creator_id"
  validates :neighborhood_id, :presence => true
	has_and_belongs_to_many :participants, :class_name => "User", :join_table => "events_users", :uniq => true
	
	geocoded_by :geocode_address

	after_validation :geocode
	
	def geocode_address
		return "#{self.street} #{self.city}, #{self.zip} #{self.state}"
	end
	
end
