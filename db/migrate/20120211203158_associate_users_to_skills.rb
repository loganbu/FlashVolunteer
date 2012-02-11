class AssociateUsersToSkills < ActiveRecord::Migration
    def self.up
        create_table :users_skills, :id => false do |t|
            t.integer :skill_id
            t.integer :user_id
        end
    end

    def down
        delete_table :users_skills
    end
end
