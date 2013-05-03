class ChangeEventToPoint < ActiveRecord::Migration

  class Event < ActiveRecord::Base
  end

  def up
    add_column :events, :lonlat, :point
    Event.reset_column_information
    Event.all.each do |event|
      event.lonlat = "POINT(#{event.longitude} #{event.latitude})"
      event.save!
    end
  end

  def down
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    Event.reset_column_information
    Event.all.each do |event|
      event.longitude = event.lonlat.x
      event.latitude = event.lonlat.y
      event.save!
    end
    remove_column :events, :lonlat
  end
end
