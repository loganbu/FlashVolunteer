class AddUseridToSite < ActiveRecord::Migration
  def self.up
    change_table :sites do |t|
      t.references :User
    end
  end

  def self.down
  end
end
