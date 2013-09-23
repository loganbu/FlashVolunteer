class EventObserver < ActiveRecord::Observer
  def after_destroy(event)
    event.participants.each do |user|
      if Rails.env.production?
        UserMailer.delay.event_deleted(event, user)
      else
        UserMailer.event_deleted(event, user).deliver
      end
    end
  end

  def before_save(event)
    event.lonlat = "POINT(#{event.longitude} #{event.latitude})"
  end
end