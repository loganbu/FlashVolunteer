class Neighborhood < ActiveRecord::Base
  include ApplicationHelper

  attr_accessible :state, :county, :city, :name, :region

  # Notice: uses cartesian coordinates, instead of world coordinates.
  def self.closest(point)
    self.find_by_sql("SELECT *, (GLength(LineString(GeomFromText('#{point}'), center))) AS distance FROM neighborhoods ORDER BY distance ASC LIMIT 1").first
  end

  def self.contains(point)
    self.find_by_sql("SELECT * FROM neighborhoods WHERE MBRContains(region, GeomFromText('#{point}')) LIMIT 1").first
  end

  def self.has_events(wkb)
    self.find_by_sql("SELECT DISTINCT neighborhoods.*, (GLength(LineString(GeomFromText('#{wkb}'), center))) AS distance FROM neighborhoods JOIN events WHERE MBRContains(region, events.lonlat) AND events.start > NOW() HAVING distance < 2 ORDER BY neighborhoods.name asc")
  end

  def participations(focus)
    participations_source(focus).includes(:participations).map(&:participations).flatten
  end

  def volunteer_hours(focus)
    participations(focus).map{|p| p.hours_volunteered == nil ? 0 : p.hours_volunteered}.inject(0,:+)
  end

  def volunteers(focus)
    participations(focus).map(&:user)
  end

  scope :supported, lambda {
    where('state = ?', :wa)
  }

  def latitude
    center.y
  end

  def longitude
    center.x
  end

  def zoom
    13
  end

  def full_name
    "#{name}, #{city}"
  end

  def score(focus)
    if User.in_neighborhood(self).count == 0
      0
    else
      (volunteers(focus).count/User.in_neighborhood(self).count)*volunteer_hours(focus)
    end
  end

  def allstar
    User.in_neighborhood(self).sort_by(&:score).reverse.first
  end

  def participations_source(focus)
    if focus == 'event'
      events
    else
      User.where(:neighborhood_id => self.id)
    end
  end

  def score_event
    score('event')
  end

  def score_user
    score('user')
  end

  def events
    Event.where(:neighborhood_id => self.id)
  end
end
