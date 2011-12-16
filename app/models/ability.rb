class Ability
  include CanCan::Ability

  
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # evetyone can read event and neighborhood
    can :read, [Event, Neighborhood]
    can :in, [Event]
    
    if user.role? :super_admin
      #super admins can do everything
      can :manage, :all
    elsif user.role? :site_admin
      #site admins can manage any event or neighborhood
      can :manage, [Event, Neighborhood]
    elsif user.role? :organization or user.role? :volunteer
      # Organizations and Volunteers can only manage their own events
      can :create, Event
      can :manage, Event do |event|
        event.try(:user) == user
      end
    end
  end
  
end
