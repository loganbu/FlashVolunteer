class Event < ActiveRecord::Base
    belongs_to :neighborhood, :foreign_key => "neighborhood_id"
    belongs_to :user, :foreign_key => "creator_id"
    validates :creator_id, :presence => { :message => "Somebody must create this event" }
    validates :neighborhood_id, :presence => { :message => "The event must have a neighborhood" }
    validates :zip, :presence => { :message => "The event must have a zip code" }
    validates :name, :presence => { :message => "The event must have a title" }
    validates :street, :presence => { :message => "The event must have an address" }
    validates :start, :presence => { :message => "The event must have a start time" }
    validates :start, :date => { :after => Time.now, :message=> "The event must begin in the future" }, :on => :create
    validates :end, :presence => { :message => "The event must have an end time" }, :date  => { :after => :start, :message=> "The event must end after the start time" }
    validates :description, :presence => { :message => "The event must have a description" }
    has_many :participations
    has_many :participants, :through => :participations, :source => :user
    has_and_belongs_to_many :skills, :join_table => "skills_events"


    geocoded_by :geocode_address

    after_validation :geocode

    scope :upcoming, lambda { |days=false|
        # Over 9000 days is probably long enough in the future. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
        where("end >= ? AND end <= ?", Time.now, Time.now + (days || 9001).days)
    }
    scope :past, lambda { |days=false|
        # Over 9000 days is probably long enough in the past. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
        where("end < ? AND end >= ?", Time.now, Time.now - (days || 9001).days)
    }
    scope :attended_by, lambda { |user|
        includes(:participants).where("users.id = ?", user.id)
    }
    scope :not_attended_by, lambda { |user|
        includes(:participants).where("users.id != ?", user.id)
    }
    scope :created_by, lambda { |user|
        where(:creator_id => user.id)
    }
    scope :hosted_by_org_user, lambda { |user_list|
        where{creator_id.eq_any Org.joins(:admins).where{admins_users.id.eq_any user_list}.all}
    }

    def duration
        self.end-self.start
    end

    def geocode_address
       return "#{self.street} #{self.city}, #{self.zip} #{self.state}"
    end

    def attending?(user)
        user == nil ? false : self.participants.exists?(user)
    end
    def upcoming?()
        self.end > Time.now
    end
end
