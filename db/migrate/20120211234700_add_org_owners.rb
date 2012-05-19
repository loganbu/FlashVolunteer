class AddOrgOwners < ActiveRecord::Migration
    def self.up
        create_table :orgs_admins, :id => false do |t|
            t.integer :user_id
            t.integer :org_id
        end
    end

    def down
        delete_table :orgs_admins
    end
end
