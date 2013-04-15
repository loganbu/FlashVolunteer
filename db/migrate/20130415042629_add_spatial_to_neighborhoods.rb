class AddSpatialToNeighborhoods < ActiveRecord::Migration

  def self.table_engine(table, engine='InnoDB')
  end
  def up
    execute "ALTER TABLE `neighborhoods` ENGINE = MyISAM"
    add_column :neighborhoods, :region, :polygon, :null => false
    add_column :neighborhoods, :state, :string
    add_column :neighborhoods, :city, :string
    add_column :neighborhoods, :county, :string
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
    add_column :neighborhoods, :latitude, :float
    add_column :neighborhoods, :longitude, :float
    remove_index :neighborhoods, :region
  end
end
