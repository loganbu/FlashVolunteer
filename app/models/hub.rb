class Hub < ActiveRecord::Base
  def self.closest(point)
    self.find_by_sql("SELECT *, (GLength(LineString(GeomFromText('#{point}'), center))) AS distance FROM hubs ORDER BY distance ASC LIMIT 1").first
  end

  # Fix center not having a X/Y. mysql2 spatial adapter isn't working propertly
  def latitude
    center.y
  end

  def longitude
    center.x
  end

  attr_accessible :name, :city_state, :center, :zoom, :radius
end
