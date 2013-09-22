class Hub < ActiveRecord::Base
  def latitude
    center.y
  end

  def longitude
    center.x
  end
end
