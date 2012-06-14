class User < ActiveRecord::Base
  include ActiveModel::Validations
  validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?, :message => "This e-mail address is already taken"
  validates_format_of     :email, :with  => /\A[^@]+@[^@]+\z/, :allow_blank => true, :if => :email_changed?, :message => "You must specify a valid e-mail address"
  validates               :email, :presence => { :message => "You must specify an e-mail address" }

  validates_presence_of     :password, :if => :password_required?, :message => "You must specify a password"
  validates_confirmation_of :password, :if => :password_required?, :message => "Your passwords do not match"
  validates_length_of       :password, :within => 6..128, :allow_blank => true, :message => "The password must be more than 6 characters"

  validates :name, :presence => { :message => "You must have a name" }
  validates_acceptance_of :terms_of_service, :on => :create, :message => "must be accepted"

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :admin_of, :class_name => "Org", :join_table => "orgs_admins", :uniq => true
  has_attached_file :avatar, :storage => :s3, :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY'],
      :secret_access_key => ENV['AWS_SECRET_KEY'],
      :bucket => ENV['AWS_BUCKET']
    }, :path => ":attachment/:id/:style.:extension",
    :styles => { :thumb => ["32x32#", :png], :profile => ["128x128#", :png]},
    :default_url => "/assets/default_user_:style.png"
  has_and_belongs_to_many :followers, :class_name => "User", :join_table => "users_followers", :association_foreign_key => "follower_id", :uniq => true
  has_many :participations
  has_many :events_participated, :through => :participations, :source => :event
  belongs_to :neighborhood

  attr_accessor :account_type
  attr_accessor :terms_of_service
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :terms_of_service, :name, :email, :password, :password_confirmation, :remember_me, :avatar, :birthday, :neighborhood_id, :skill_ids, :account_type, :hours_volunteered

  def hours_volunteered(event=nil)
    if (event != nil)
      Participation.where("user_id = ? AND event_id = ?", self.id, event.id).sum(:hours_volunteered)
    else
      Participation.where("user_id = ?", self.id).sum(:hours_volunteered)
    end
  end

  # Comma-delimited string of skills, for the mobile API
  def categories
    skills.map{|s| s.id }.join(',')
  end

  def props
    Prop.received_by(self).count
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def should_show_wizard?
    !neighborhood_id || !skills.length
  end

  def password_match?
    self.errors[:password] << 'password not match' if password != password_confirmation
    self.errors[:password] << 'you must provide a password' if password.blank?
    password == password_confirmation and !password.blank?  
  end

  def create_associated_org(org_email, org_name)
    org = Org.new(:email => org_email, :password => Devise.friendly_token[0,20], :name =>org_name)
    org.admins << self
    org.save!
  end

  def self.find_for_oauth(access_token)
    data = access_token.extra.raw_info
    if !(user = User.where(:email => data.email).first)
      user = User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :name => data.name)
      user.confirm!
    end
    user
  end
  
  def password_required?
    if (password.nil? && password_confirmation.nil?)
      return false
    else
      return true
    end
  end

  def self.xml(entity)
    entity.to_xml(:methods => [:hours_volunteered, :categories, :props])
  end
end
