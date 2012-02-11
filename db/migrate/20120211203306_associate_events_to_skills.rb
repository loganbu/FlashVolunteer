class AssociateEventsToSkills < ActiveRecord::Migration
    def self.up
        create_table :events_skills, :id => false do |t|
            t.integer :skill_id
            t.integer :event_id
        end
    end


    def self.down
        delete_table :events_skills
    end
end
