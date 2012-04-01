class RenameEventsUsersToParticipants < ActiveRecord::Migration
  def up
    rename_table :events_users, :participations
    add_column :participations, :hours_volunteered, :integer
  end

  def down
    remove_column :participations, :hours_volunteered
    rename_table :participations, :events_users
  end
end
