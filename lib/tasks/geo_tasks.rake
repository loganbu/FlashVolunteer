namespace :fv do
    desc 'Update the hubs in the SQL database'
    task :update_hubs => :environment do
      Hub.delete_all
      hubs = YAML::load(ERB.new(File.read("#{Rails.root}/db/hubs.yml")).result)
      Hub.create(hubs['hubs'])
    end

    desc 'Update the neighborhoods in the SQL database'
    task :update_neighborhoods => :environment do
      Neighborhood.delete_all
      %w(wa or il).each do |state|
        contents = File.read("#{Rails.root}/db/data/neighborhoods/#{state}.json")
        geom = RGeo::GeoJSON.decode(contents, :json_parser => :json)
        geom.each do |neighborhood|
          state = neighborhood.properties['STATE']
          county = neighborhood.properties['COUNTY']
          city = neighborhood.properties['CITY']
          name = neighborhood.properties['NAME']
          neighborhood = Neighborhood.create(:state => state, :county => county, :city => city, :name => name, :region => neighborhood.geometry)
          ActiveRecord::Base.connection.execute("UPDATE Neighborhoods SET center=Centroid(region) WHERE id=#{neighborhood.id}")
        end
      end
    end
end