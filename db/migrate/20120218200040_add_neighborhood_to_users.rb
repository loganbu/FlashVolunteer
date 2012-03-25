class AddNeighborhoodToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :neighborhood
    end
  end

  def down
    remove_column :users, :neighborhood_id
  end
end
