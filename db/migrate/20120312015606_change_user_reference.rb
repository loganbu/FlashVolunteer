class ChangeUserReference < ActiveRecord::Migration
  def up
    remove_column :users, :orgs_id

    change_table :users do |t|
        t.references :org
    end
  end

  def down
  end
end
