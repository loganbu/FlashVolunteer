class AddNewNeighborhoodsDesmoinesFedway < ActiveRecord::Migration
  def change
    fw = Neighborhood.new(:name => "Federal Way", :latitude => 47.300800, :longitude => -122.329460)
    fw.save!
    dm = Neighborhood.new(:name => "Des Moines", :latitude => 47.407810, :longitude => -122.319892)
    dm.save!
  end
end
