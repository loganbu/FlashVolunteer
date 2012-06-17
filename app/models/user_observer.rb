class UserObserver < ActiveRecord::Observer
    def after_create(user)
        Notification.all.each do |n|
            user.notification_preferences << n
        end
        user.save
    end
end