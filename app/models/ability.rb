class Ability
  include CanCan::Ability

  
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # evetyone can read event and neighborhood
    can :read, [Event, Neighborhood, User]
    can :in, [Event]
    can :export, [Event]

    
    if user.role? :super_admin
      #super admins can do everything
      can :manage, :all
    elsif user.role? :site_admin
      #site admins can manage any event or neighborhood
      can :manage, [Event, Neighborhood]
    elsif user.role? :organization or user.role? :volunteer
      # Organizations and Volunteers can only manage their own events

      # Only "confirmed" users can create events
      can :create, Event if user.confirmed?

      can :manage, Event do |event|
        event.try(:user) == user
      end
    end
    can :manage, User do |other|
      other == user
    end
  end
  
end
