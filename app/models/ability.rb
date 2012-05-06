class Ability
  include CanCan::Ability
  include ApplicationHelper
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # everyone can read event and neighborhood
    can :read, [Event, Neighborhood, User]
    can :in, [Event]
    can :export, [Event]
    can :switch, [User]
    can :search, [Event, User, Neighborhood]
    can :instructions, [Event]

    can :see_events, [User] do |other|
      privacy_settings = Privacy.find_by_user_id(other.id)
      other == user || privacy_settings == nil || privacy_settings.upcoming_events.everyone?
    end

    if user.role? :super_admin
      #super admins can do everything
      can :manage, :all
      can :switch, User if Rails.env.development?
    elsif user.role? :volunteer
      # Organizations and Volunteers can only manage their own events
      can :manage, Event do |event|
        event.try(:user) == user
      end

      # Only "confirmed" users can create events
      can :create, Event if user.confirmed?
    end
    can :manage, User do |other|
      other == user
    end
  end
end
