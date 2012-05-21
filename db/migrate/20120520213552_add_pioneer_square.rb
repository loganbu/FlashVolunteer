class AddPioneerSquare < ActiveRecord::Migration
  def change
    ps = Neighborhood.new(:name => "Pioneer Square", :latitude => 47.601692, :longitude => -122.332305)
    ps.save!
  end
end
