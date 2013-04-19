class Event < ActiveRecord::Base
    belongs_to :neighborhood, :foreign_key => "neighborhood_id"
    belongs_to :user, :foreign_key => "creator_id"
    validates :creator_id, :presence => { :message => "Somebody must create this event" }
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

    has_attached_file :photo_featured, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :featured => ["760x350#", :png], :large => ["290x200#", :png]},
    :default_url => "/assets/default_event_:style.png"

    has_attached_file :photo_2, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :large => ["290x200#", :png]},
    :default_url => "/assets/default_event_:style.png"

    has_attached_file :photo_3, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :large => ["290x200#", :png]},
    :default_url => "/assets/default_event_:style.png"

    has_attached_file :photo_4, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :large => ["290x200#", :png]},
    :default_url => "/assets/default_event_:style.png"

    has_attached_file :photo_5, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :large => ["290x200#", :png]},
    :default_url => "/assets/default_event_:style.png"

    scope :upcoming, lambda { |days=false|
        end_time = Time.now + (days || 9001).days unless days == 0
        end_time = DateTime.now.end_of_day if days == 0
        # Over 9000 days is probably long enough in the future. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
        where("end >= ? AND end <= ?", Time.now, end_time)
    }
    scope :before, lambda { |date|
        where("end <= ?", date)
    }
    scope :after, lambda { |date|
        where("end >= ?", date)
    }
    scope :past, lambda { |days=false|
        end_time = Time.now - (days || 9001).days unless days == 0
        end_time = DateTime.now.beginning_of_day if days == 0
        # Over 9000 days is probably long enough in the past. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
        where("end < ? AND end >= ?", Time.now, end_time)
    }
    scope :attended_by, lambda { |user|
        includes(:participants).where("users.id = ?", user.id)
    }
    scope :not_attended_by, lambda { |user|
        includes(:participants).where("#{user.id} not in (SELECT user_id FROM participations WHERE event_id = events.id)")
    }
    scope :created_by, lambda { |user|
        where(:creator_id => user.id)
    }
    scope :involving, lambda { |user|
        includes(:participants).where("users.id = ? or (creator_id = ? AND (hosted_by IS NULL OR hosted_by = ''))", user.id, user.id)
    }
    scope :hosted_by_org_user, lambda { |user_list|
        where{creator_id.eq_any Org.joins(:admins).where{admins_users.id.eq_any user_list}.all}
    }
    scope :featured, lambda {
        where("featured = ?", true)
    }
    scope :recommended_to, lambda { |user|
        if (user.skills.count > 0)
            not_attended_by(user).upcoming.joins(:skills).where{skills.id.eq_any user.skills}
        else
            not_attended_by(user).upcoming
        end
    }
    scope :in_neighborhood, lambda { |neighborhood|
        joins("INNER JOIN neighborhoods ON MBRContains(neighborhoods.region, events.lonlat)").where("neighborhoods.id = ?", neighborhood)
    }

    def hosted_by_real_user
        !self.hosted_by.blank?
    end

    def near_happening
        Time.now > self.start-2.hours && Time.now < self.end+2.hours
    end

    def hosted_by_user
        self.hosted_by == nil || self.hosted_by == ""
    end

    def duration
        self.end-self.start
    end

    # For XML response
    def attendees
        participants.map{|s| s.id }.join(',')
    end
    # For XML response
    def categories
        skills.map{|s| s.id }.join(',')
    end

    def geocode_address
       return "#{self.street} #{self.city}, #{self.zip} #{self.state}"
    end

    def attending?(user)
        user == nil ? false : self.participants.exists?(user)
    end

    def upcoming?
        self.end > Time.now
    end

    def past?
        self.end < Time.now
    end

    def is_vm
      !(vm_id == nil || vm_id == 0)
    end

    def self.xml(entity)
        entity.to_xml(:methods => [:attendees, :categories, :latitude, :longitude])
    end

    def self.json(entity)
        entity.to_json(:methods => [:attendees, :categories, :latitude, :longitude])
    end
end
