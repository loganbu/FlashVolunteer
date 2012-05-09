class AddNewNeighborhoods < ActiveRecord::Migration
  def change
    downtown = Neighborhood.find_by_name("Downtown")
    if (downtown != nil)
        downtown.name = "Downtown Seattle"
        downtown.save!
    end
    mt = Neighborhood.new(:name => "Mountlake Terrace", :latitude => 47.788028, :longitude => -122.311111)
    mt.save!
    ro = Neighborhood.new(:name => "Roosevelt", :latitude => 47.680877, :longitude => -122.317115)
    ro.save!
    kent = Neighborhood.new(:name => "Kent", :latitude => 47.380279, :longitude => -122.237419)
    kent.save!
    seatac = Neighborhood.new(:name => "Seatac", :latitude => 47.434059, :longitude => -122.274261)
    seatac.save!
  end
end
