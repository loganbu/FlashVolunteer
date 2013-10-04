class AddLinkToAffiliate < ActiveRecord::Migration

  def change
    add_column :affiliates, :link, :string
  end
end