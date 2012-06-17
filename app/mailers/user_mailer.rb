class UserMailer < ActionMailer::Base
    default :from => "charlie@flashvolunteer.org"

    def prop_received(prop)
        @prop = prop
        mail(:to => @prop.receiver.email,
             :subject => "#{@prop.giver.name} gave you props")
    end

    def organizer_broadcast(event, user, message)
        @event = event
        @host = event.user
        @attendee = user
        @message = message
        mail(:to => @user.email,
             :subject => "A message from #{@event.name}'s organizer")
    end

    def new_event_attendee(participation)
        @participation = participation
        @event = participation.event
        @host = participation.event.user
        @user_signed_up = participation.user

        mail(:to => @host.email,
             :subject => "New volunteer signup for #{@event.name}")
    end

end