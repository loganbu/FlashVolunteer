class AssociateEventsToSkills < ActiveRecord::Migration
    def self.up
        create_table :skills_events, :id => false do |t|
            t.integer :skill_id
            t.integer :event_id
        end
    end

    def self.down
        delete_table :skills_events
    end
end
