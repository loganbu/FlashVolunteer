class AddOrgInformation < ActiveRecord::Migration
    def up
        change_table :orgs do |t|
            t.string :vision
            t.string :mission
            t.text :description
        end
        change_table :users do |t|
            t.references :orgs
        end
    end
    def down
        remove_column :orgs, :vision
        remove_column :orgs, :mission
        remove_column :orgs, :description
        remove_column :users, :orgs_id
    end
end
