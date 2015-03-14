class Event < ActiveRecord::Base
  belongs_to :neighborhood, :foreign_key => 'neighborhood_id'
  belongs_to :user, :foreign_key => 'creator_id'
  validates :creator_id, :presence => { message: 'Somebody must create this event' }
  validates :name, :presence => { message: 'The event must have a title' }
  validates_length_of :name, :maximum => 255, :message => 'The event title must be less than 255 characters'
  validates :street, :presence => { message: 'The event must have an address' }
  validates :start, :presence => { message: 'The event must have a start time' }
  validates :start, :date => { after: Time.now, message: 'The event must begin in the future' }, :on => :create
  validates :end, :presence => { message: 'The event must have an end time' }, :date  => { after: :start, message: 'The event must end after the start time' }
  validates :description, :presence => { message: 'The event must have a description' }
  validates_length_of :description, :maximum => 2000, :message => 'The event description must be less than 2000 characters'
  validates_length_of :special_instructions, :maximum => 2000, :message => 'The event special instructions must be less than 2000 characters'

  has_many :participations
  accepts_nested_attributes_for :participations

  has_many :participants, :through => :participations, :source => :user
  has_and_belongs_to_many :skills, :join_table => 'skills_events'
  has_many :event_affiliations
  has_many :affiliates, :through => :event_affiliations

  geocoded_by :geocode_address

  after_validation :geocode_if_necessary

  has_attached_file :photo_featured, :storage => :s3, :s3_credentials => {
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_KEY'],
      bucket: ENV['AWS_BUCKET']
  }, :path => ':attachment/:id/:style.:extension',
  :styles => { featured: ['760x350#', :png], large: ['290x200#', :png]},
  :default_url => '/assets/default_event_:style.png'

  has_attached_file :photo_2, :storage => :s3, :s3_credentials => {
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
    bucket: ENV['AWS_BUCKET']
  }, :path => ':attachment/:id/:style.:extension',
  :styles => { large: ['290x200#', :png]},
  :default_url => '/assets/default_event_:style.png'

  has_attached_file :photo_3, :storage => :s3, :s3_credentials => {
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
    bucket: ENV['AWS_BUCKET']
  }, :path => ':attachment/:id/:style.:extension',
  :styles => { large: ['290x200#', :png]},
  :default_url => '/assets/default_event_:style.png'

  has_attached_file :photo_4, :storage => :s3, :s3_credentials => {
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
    bucket: ENV['AWS_BUCKET']
  }, :path => ':attachment/:id/:style.:extension',
  :styles => { large: ['290x200#', :png]},
  :default_url => '/assets/default_event_:style.png'

  has_attached_file :photo_5, :storage => :s3, :s3_credentials => {
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
    bucket: ENV['AWS_BUCKET']
  }, :path => ':attachment/:id/:style.:extension',
  :styles => { large: ['290x200#', :png]},
  :default_url => '/assets/default_event_:style.png'

  scope :upcoming, lambda { |days=false|
    end_time = nil
    end_time = Time.now + (days || 9001).days unless days == 0
    end_time = DateTime.now.end_of_day if days == 0
    # Over 9000 days is probably long enough in the future. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
    where('end >= ? AND end <= ?', Time.now, end_time)
  }
  scope :before, lambda { |date|
    where('end <= ?', date)
  }
  scope :after, lambda { |date|
    where('end >= ?', date)
  }
  scope :past, lambda { |days=false|
    end_time = nil
    end_time = Time.now - (days || 9001).days unless days == 0
    end_time = DateTime.now.beginning_of_day if days == 0
    # Over 9000 days is probably long enough in the past. Otherwise, this app rocks, and I'll will "won't-fix" this bug.
    where('end < ? AND end >= ?', Time.now, end_time)
  }

  scope :created_by_user, lambda { |user|
    created_by(user).order('start asc')
  }

  scope :involving_user, lambda { |user|
    includes(:affiliates, :skills, :user).involving(user).order('start asc')
  }

  scope :attended_by, lambda { |user|
    includes(:participants).where('users.id = ?', user.id)
  }
  scope :not_attended_by, lambda { |user|
    includes(:participants).where("#{user.id} not in (SELECT user_id FROM participations WHERE event_id = events.id)")
  }
  scope :created_by, lambda { |user|
    where(:creator_id => user.id).order('start asc')
  }
  scope :involving, lambda { |user|
    includes(:participants).where("participations.user_id = ? or (creator_id = ? AND (hosted_by IS NULL OR hosted_by = ''))", user.id, user.id)
  }
  scope :hosted_by_org_user, lambda { |user_list|
    where{creator_id.eq_any Org.joins(:admins).where{admins_users.id.eq_any user_list}.all}
  }
  scope :featured, lambda {
    where('featured = ?', true)
  }
  scope :recommended_to, lambda { |user|
    if user.skills.count > 0
      includes(:affiliates, :skills, :user).not_attended_by(user).upcoming.joins(:skills).where{skills.id.eq_any user.skills}.order('start asc')
    else
      includes(:affiliates, :skills, :user).not_attended_by(user).upcoming.order('start asc')
    end
  }
  scope :in_neighborhood, lambda { |neighborhood|
    joins('INNER JOIN neighborhoods ON MBRContains(neighborhoods.region, events.lonlat)').where('neighborhoods.id = ?', neighborhood)
  }

  scope :near_user, lambda { |hub|
    near([hub.latitude, hub.longitude], hub.radius)
  }

  def hosted_by_real_user
    !self.hosted_by.blank?
  end

  def near_happening
    Time.now > self.start-2.hours && Time.now < self.end+2.hours
  end

  def hosted_by_user
    self.hosted_by == nil || self.hosted_by == ''
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
   "#{self.street} #{self.city}, #{self.zip} #{self.state}"
  end

  def should_geocode?
    latitude == 0 || latitude == nil || longitude == nil || longitude == 0 || !moved_marker
  end

  def geocode_if_necessary
    geocode if should_geocode?
  end

  def attending?(user)
    participants.where('user_id = ?', user.id).any? unless user == nil
  end

  def upcoming?
    self.end > Time.now
  end

  def full?
    self.limited_spots? && self.open_spots == 0
  end

  def limited_spots?
    (self.max_users||0) > 0
  end

  def open_spots
    (self.max_users||0) - self.participants.count
  end

  def can_register?
    if (self.limited_spots?)
      return self.open_spots > 0
    end
    true
  end

  def past?
      self.end < Time.now
  end

  def is_vm
    !(vm_id == nil || vm_id == 0)
  end

  def visible_affiliates(user)
    user ||= User.new
    (affiliates || []).select{|a| user.can? :read, a}
  end

  def self.xml(entity)
    entity.to_xml(:methods => [:attendees, :categories])
  end

  def self.json(entity)
    entity.to_json(:methods => [:attendees, :categories])
  end
end
