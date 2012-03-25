class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :created
      t.datetime :start
      t.datetime :end
      t.references :neighborhood
      t.references "creator", :User
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
