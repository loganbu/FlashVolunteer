class PopulateFriendlyNames < ActiveRecord::Migration

  def friendly_name(str)
    str.gsub(/[^\w\s_-]+/, '')
    .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
    .gsub(/\s+/, '_')
  end

  def up
    Neighborhood.all.each do |n|
      n.city_friendly = friendly_name(n.city)
      n.name_friendly = friendly_name(n.name)
      n.save!
    end
  end
end
