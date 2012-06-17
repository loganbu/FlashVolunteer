class CreateNotifications < ActiveRecord::Migration
    def change
        create_table :notifications do |t|
            t.string :name
            t.string :description
        end
        # Initial notifications
        n = Notification.new(:name => "prop_received", :description=>"Some other user gave you props")
        n.save!
        n = Notification.new(:name => "new_event_attendee", :description=>"Someone signs up for an event I'm coordinating")
        n.save!
        n = Notification.new(:name => "organizer_broadcast", :description=>"An event organizer wishes to contact me about an event I'm signed up for")
        n.save!

        User.all.each do |u|
            Notification.all.each do |n|
                u.notification_preferences << n
            end
            u.save
        end
    end
end