class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :in, :export, :search, :instructions, :to => :read

    # everyone can read event and neighborhood
    can :read, [Event, Neighborhood, User]
    can :switch, [User] # Switching does additional checks against session data that we can't do here

    cannot :see_profile, [User, Org] # Assume the user isn't the same, the :manage below takes care of overriding this

    # Only the owning user is allowed to manager their own org/user profile
    can :manage, User do |other|
      other == user && user.type != "Org"
    end
    can :manage, Org do |other|
      other == user && user.type == "Org"
    end
    can :manage, Event do |event|
      event.try(:user) == user
    end

    can :see_events, [User] do |other|
      privacy_settings = Privacy.find_by_user_id(other.id)
      other == user || privacy_settings == nil || privacy_settings.upcoming_events.everyone?
    end

    cannot :create, [Event, Org]
    can :create, [Event, Org] if user.confirmed?

    if user.role? :super_admin
        #super admins can do everything
        can :manage, :all
    end

  end
end
