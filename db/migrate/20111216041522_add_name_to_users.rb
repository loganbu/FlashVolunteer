class AddNameToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :name
      t.remove :firstname, :lastname
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :name
      t.string :firstname
      t.string :lastname
    end
  end
end
