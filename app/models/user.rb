class User < ActiveRecord::Base
  include ActiveModel::Validations
  validates_acceptance_of :terms_of_service, :on => :create, :message => "must be accepted"
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :terms_of_service, :email, :password, :password_confirmation, :remember_me
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def password_match?
    self.errors[:password] << 'password not match' if password != password_confirmation
    self.errors[:password] << 'you must provide a password' if password.blank?
    password == password_confirmation and !password.blank?  
  end
end
