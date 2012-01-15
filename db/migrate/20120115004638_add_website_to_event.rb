class AddWebsiteToEvent < ActiveRecord::Migration
  def self.up
  	change_table :events do |t|
  		t.string :website
	end
  end

  def self.down
  	remove_column :events, :website
  end
end
