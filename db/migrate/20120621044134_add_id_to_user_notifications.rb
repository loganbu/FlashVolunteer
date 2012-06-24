class AddIdToUserNotifications < ActiveRecord::Migration
  def change
    add_column :user_notifications, :id, :primary_key
  end
end
