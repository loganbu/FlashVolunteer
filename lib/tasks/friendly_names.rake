namespace :fv do

    def friendly_name(str)
      str.gsub(/[^\w\s_-]+/, '')
      .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
      .gsub(/\s+/, '_')
    end

    desc "Make city names friendly"
    task :friendly_names => :environment do
      Neighborhood.all.each do |n|
        if (n.city_friendly == nil || n.name_friendly == nil)
          n.city_friendly = friendly_name(n.city)
          n.name_friendly = friendly_name(n.name)
          n.save!
        end
      end
    end
end
