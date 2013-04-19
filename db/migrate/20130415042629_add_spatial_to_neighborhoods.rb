class AddSpatialToNeighborhoods < ActiveRecord::Migration
  def up
    Neighborhood.delete_all()
    execute "ALTER TABLE `neighborhoods` ENGINE = MyISAM"
    add_column :neighborhoods, :region, :polygon, :null => false
    add_column :neighborhoods, :state, :string
    add_column :neighborhoods, :city, :string
    add_column :neighborhoods, :county, :string
    add_column :neighborhoods, :center, :point
    remove_column :neighborhoods, :latitude
    remove_column :neighborhoods, :longitude
    add_index :neighborhoods, :region, :spatial => true
  end
  def down
    execute "ALTER TABLE `neighborhoods` ENGINE = InnoDB"
    remove_column :neighborhoods, :region
    remove_column :neighborhoods, :state
    remove_column :neighborhoods, :city
    remove_column :neighborhoods, :county
    remove_column :neighborhoods, :center
    add_column :neighborhoods, :latitude, :float
    add_column :neighborhoods, :longitude, :float
    remove_index :neighborhoods, :region
  end
end
