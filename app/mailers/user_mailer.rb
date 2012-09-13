class UserMailer < ActionMailer::Base
    include ApplicationHelper
    if self.included_modules.include?(AbstractController::Callbacks)
        raise "You've already included AbstractController::Callbacks, remove this line."
    else
        include AbstractController::Callbacks
    end

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
        @message = display_text_field_safe(message)
        mail(:to => @attendee.email,
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

    def event_deleted(event, user)
        @event = event
        @user = user
        mail(:to => @user.email,
             :subject => "Event Cancellation: #{@event.name}")
    end

    private
    
    def add_inline_attachments!
        attachments.inline["logo.jpg"] = File.read( File.join(Rails.root, 'app/assets/images/FV_Logo_420x420.jpg') )
        attachments.inline["spacer.jpg"] = File.read( File.join(Rails.root, 'app/assets/images/spacer.jpg') )
    end
end