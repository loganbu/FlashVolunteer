class ParticipationObserver < ActiveRecord::Observer
  def after_create(participation)
    if participation.event.hosted_by_user && participation.event.user.notification_preferences.where(:name => 'new_event_attendee').count > 0
      if Rails.env.production?
        UserMailer.delay.new_event_attendee(participation)
      else
        UserMailer.new_event_attendee(participation).deliver
      end
    end

    if participation.event.is_vm
      VolunteerMatch.sign_up_for_opportunity(VolunteerMatch.create_or_update_user(participation.user), participation.event.vm_id)
    end
  end
end