class AddUserFollowers < ActiveRecord::Migration
    def self.up
        create_table :users_followers, :id => false do |t|
            t.integer :user_id
            t.integer :follower_id
        end
    end

    def down
        delete_table :users_followers
    end
end
