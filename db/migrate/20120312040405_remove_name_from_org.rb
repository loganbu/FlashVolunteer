class RemoveNameFromOrg < ActiveRecord::Migration
  def change
    remove_column :orgs, :name
  end
end
