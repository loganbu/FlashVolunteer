class AddPublicToAffiliate < ActiveRecord::Migration
  def change
    add_column :affiliates, :public, :boolean
  end
end
