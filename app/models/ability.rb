class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :in, :export, :search, :instructions, :to => :read

    if user.role? :super_admin
        #super admins can do everything
        can :manage, :all
    else
      # everyone can read event and neighborhood
      can :read, [Event, Neighborhood, User]
      can :switch, [User] # Switching does additional checks against session data that we can't do here

      cannot :see_profile, [User, Org] # Assume the user isn't the same, the :manage below takes care of overriding this

      can :manage, User do |other|
        # Only the owning user is allowed to manager their own user profile
        other == user && user.type != 'Org'
      end
      can :manage, Org do |other|
        # Allow the org user to manage itself
        (other == user && user.type == 'Org' ||
         # Allow the org's admins to manage the org
         other.admins.where{id == user.id}.length > 0
	)
      end

      can :manage, Event do |event|
        event.try(:user) == user || event.affiliates.select{|a| user.moderator_of?(a)}.any?
      end

      can :manage, [Affiliate] do |affiliate|
        user.moderator_of?(affiliate)
      end

      can :read, [Affiliate] do |affiliate|
        affiliate.public? || user.affiliates.include?(affiliate)
      end

      can :see_events, [User] do |other|
        privacy_settings = Privacy.find_by_user_id(other.id)
        other == user || privacy_settings == nil || privacy_settings.upcoming_events.everyone?
      end

      cannot :create, [Event, Org]
      can :create, [Event, Org] if user.confirmed?
    end
  end
end
