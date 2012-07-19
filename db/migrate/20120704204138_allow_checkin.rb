class AllowCheckin < ActiveRecord::Migration
  def change
  	create_table :checkins do |t|
    	t.references :event
   		t.references :user
  	end
  end
end
