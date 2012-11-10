class AddPhotosToEvent < ActiveRecord::Migration
  def change
    add_attachment :events, :photo_featured
    add_attachment :events, :photo_2
    add_attachment :events, :photo_3
    add_attachment :events, :photo_4
    add_attachment :events, :photo_5
  end
end
