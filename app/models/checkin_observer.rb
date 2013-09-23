class CheckinObserver < ActiveRecord::Observer
  def after_create(checkin)
    unless checkin.event.participants.include?(checkin.user)
      checkin.event.participants << checkin.user
    end
  end
end