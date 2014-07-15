class Org < User
  has_and_belongs_to_many :admins, :class_name => 'User', :join_table => 'orgs_admins', :uniq => true
  has_and_belongs_to_many :followers, :class_name => 'User', :join_table => 'orgs_followers', :uniq => true

  attr_accessible :mission, :name, :email, :website

  self.scope :has_admin, lambda { |u|
    includes(:admins).where('admins_users.id = ?', u.id)
  }

  self.scope :has_follower, lambda { |u|
    includes(:followers).where('followers_users.id = ?', u.id)
  }

  def self.xml(entity)
    entity.to_xml(:methods => [:categories, :avatar_url])
  end

  def admin?(user)
    (admins.where{id == user.id}.length > 0)
  end

  def participations
    Participation.joins(:event).where('events.creator_id = ?', self.id)
  end

  def hours_volunteered_for_org
    participations.sum(:hours_volunteered)
  end

  def past_volunteers
    participations.map(&:user).uniq(&:id)
  end
end
