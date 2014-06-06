class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :checkins, [:event_id, :user_id]
    add_index :event_affiliations, [:affiliate_id, :event_id]
    add_index :events, :neighborhood_id
    add_index :events, :creator_id
    add_index :events, :User_id
    add_index :orgs_admins, [:user_id, :org_id]
    add_index :orgs_followers, [:user_id, :org_id]
    add_index :participations, [:user_id, :event_id]
    add_index :privacies, :user_id
    add_index :props, [:giver_id, :receiver_id]
    add_index :roles_users, [:role_id, :user_id]
    add_index :skills_events, [:skill_id, :event_id]
    add_index :skills_users, [:skill_id, :user_id]
    add_index :user_affiliations, [:affiliate_id, :user_id]
    add_index :user_notifications, [:notification_id, :user_id]
    add_index :users, [:neighborhood_id, :org_id]
    add_index :users_followers, [:user_id, :follower_id]
    add_index :volunteer_matches, :vm_id
  end
end
