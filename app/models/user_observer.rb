class UserObserver < ActiveRecord::Observer
  def before_create(user)
    Notification.all.each do |n|
      user.notification_preferences << n
    end
  end
end