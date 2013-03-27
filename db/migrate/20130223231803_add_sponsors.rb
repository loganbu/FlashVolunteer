class AddSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.attachment :logo
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :url
      t.string :name
    end
  end
end
