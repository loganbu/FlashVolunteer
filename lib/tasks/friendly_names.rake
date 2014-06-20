namespace :fv do

    def friendly_name(str)
      str.gsub(/[^\w\s_-]+/, '')
      .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
      .gsub(/\s+/, '_')
    end

    desc "Make city names friendly"
    task :friendly_names => :environment do
      Neighborhood.where('city_friendly is null or name_friendly is null').each do |n|
          Rails.logger.info("Updating #{n.name}")
          n.city_friendly = friendly_name(n.city)
          n.name_friendly = friendly_name(n.name)
          n.save!
      end
    end
end
