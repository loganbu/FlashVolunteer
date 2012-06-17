class ParticipationObserver < ActiveRecord::Observer

    def after_create(participation)
        Rails.logger.debug("User's preferences")
        Rails.logger.debug("User's preferences")
        if (participation.event.hosted_by_user && participation.event.user.notification_preferences.where(:name => "new_event_attendee").count > 0)
            if Rails.env.production?
                # send the e-mail
                UserMailer.delay.new_event_attendee(participation)
            else
                UserMailer.new_event_attendee(participation).deliver
            end
        end
    end
end