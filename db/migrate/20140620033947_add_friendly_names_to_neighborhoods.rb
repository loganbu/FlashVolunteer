class AddFriendlyNamesToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :name_friendly, :string
    add_column :neighborhoods, :city_friendly, :string
  end
end
