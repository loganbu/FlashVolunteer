class AssociateUsersToSkills < ActiveRecord::Migration
    def self.up
        create_table :skills_users, :id => false do |t|
            t.integer :skill_id
            t.integer :user_id
        end
    end

    def down
        delete_table :skills_users
    end
end
