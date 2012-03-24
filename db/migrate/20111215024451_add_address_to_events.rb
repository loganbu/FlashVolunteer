class AddAddressToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.string :street
      t.string :city
      t.integer :zip
      t.float :latitude
			t.float :longitude
			t.string :state, :default => "WA"
    end
  end

  def self.down
		remove_column :events, :street, :city, :zip, :state, :latitude, :longitude
  end
end
