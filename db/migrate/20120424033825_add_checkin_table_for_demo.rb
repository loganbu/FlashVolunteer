class AddCheckinTableForDemo < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
        t.string :email
        t.string :name
    end
  end
end
