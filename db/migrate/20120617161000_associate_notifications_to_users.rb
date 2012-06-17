class AssociateNotificationsToUsers < ActiveRecord::Migration
    def change
        create_table :user_notifications, :id => false do |t|
            t.integer :notification_id
            t.integer :user_id
        end
    end
end
