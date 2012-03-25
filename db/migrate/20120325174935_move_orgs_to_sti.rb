class MoveOrgsToSti < ActiveRecord::Migration
  def up
    drop_table :orgs
    add_column :users, :mission, :string
    add_column :users, :vision, :string
    add_column :users, :description, :text
    add_column :users, :website, :text
  end

  def down
  end
end
