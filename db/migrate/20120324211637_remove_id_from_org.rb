class RemoveIdFromOrg < ActiveRecord::Migration
  def change
    remove_column :orgs, :id
    add_column :users, :type, :string
  end
end
