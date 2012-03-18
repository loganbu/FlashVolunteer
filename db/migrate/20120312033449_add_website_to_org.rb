class AddWebsiteToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :website, :string
  end
end
