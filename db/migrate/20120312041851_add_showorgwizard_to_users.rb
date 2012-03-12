class AddShoworgwizardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_org_wizard, :boolean
  end
end
