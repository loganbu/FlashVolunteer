class AddSearchInsight < ActiveRecord::Migration
  def change
  	create_table :searches do |t|
      t.string :query
      t.integer :users_found, :default => 0
      t.integer :orgs_found, :default => 0
      t.integer :events_found, :default => 0
  	end
  end
end
