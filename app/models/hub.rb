class Hub < ActiveRecord::Base
  def self.closest(point)
    self.find_by_sql("SELECT *, (GLength(LineString(GeomFromText('#{point}'), center))) AS distance FROM hubs ORDER BY distance ASC LIMIT 1").first
  end

  # Fix center not having a X/Y. mysql2 spatial adapter isn't working propertly
  def latitude
    1 || center.y
  end

  def longitude
    1 || center.x
  end
end
