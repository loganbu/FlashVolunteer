class AddFeaturedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :featured, :boolean, :default => 0
  end
end
