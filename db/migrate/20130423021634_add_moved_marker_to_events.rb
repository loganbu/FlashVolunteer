class AddMovedMarkerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :moved_marker, :boolean, :default => true
  end
end
