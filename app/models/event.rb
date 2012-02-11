class Event < ActiveRecord::Base
    belongs_to :neighborhood, :foreign_key => "neighborhood_id"
    belongs_to :user, :foreign_key => "creator_id"
    validates :neighborhood_id, :presence => { :message => "The event must have a neighborhood" }
    validates :zip, :presence => { :message => "The event must have a zip code" }
    validates :name, :presence => { :message => "The event must have a title" }
    validates :street, :presence => { :message => "The event must have an address" }
    validates :start, :presence => { :message => "The event must have a start time" }
    validates :start, :date => { :after => Time.now, :message=> "The event must begin in the future" }, :on => :create
    validates :end, :presence => { :message => "The event must have an end time" }, :date  => { :after => :start, :message=> "The event must end after the start time" }
    validates :description, :presence => { :message => "The event must have a description" }
    has_and_belongs_to_many :participants, :class_name => "User", :join_table => "events_users", :uniq => true
    has_and_belongs_to_many :skills


    geocoded_by :geocode_address

    after_validation :geocode

    scope :upcoming, lambda {
        where("start >= ?", Date.today)
    }
    def geocode_address
       return "#{self.street} #{self.city}, #{self.zip} #{self.state}"
    end

    def attending?(user)
        user == nil ? false : self.participants.exists?(user)
    end
end
