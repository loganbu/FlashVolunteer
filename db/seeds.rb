# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.delete_all()
Role.create([
{ :name => "SuperAdmin" },
{ :name => "SiteAdmin" },
{ :name => "Organization" },
{ :name => "Volunteer" },
])

User.delete_all()
admin = User.find_or_create_by_email(:email => "admin@localhost.com", :password => ENV['ADMIN_PASSWORD'], :password_confirmation => ENV['ADMIN_PASSWORD'], :name=>"Admin")
admin.roles << Role.find_by_name("SuperAdmin")

Skill.delete_all()
Skill.create([
{ :name => "Advocacy | Human Rights",           :offset => 0 },
{ :name => "Animals",                           :offset => 1 },
{ :name => "Arts | Culture",                    :offset => 2 },
{ :name => "Children | Youth",                  :offset => 3 },
{ :name => "Computers | Technology",            :offset => 4 },
{ :name => "Disabled",                          :offset => 5 },
{ :name => "Disaster Relief",                   :offset => 6 },
{ :name => "Education | Literacy",              :offset => 7 },
{ :name => "Environment",                       :offset => 8 },
{ :name => "GLBT",   							:offset => 9 },
{ :name => "Health | Medicine",                 :offset => 10 },
{ :name => "Homeless | Housing",                :offset => 11 },
{ :name => "Hunger",                            :offset => 12 },
{ :name => "Immigrants | Refugees",             :offset => 13 },
{ :name => "Justice | Legal",                   :offset => 14 },
{ :name => "Media | Broadcasting",              :offset => 15 },
{ :name => "Politics",                          :offset => 16 },
{ :name => "Sports | Recreation",               :offset => 17 }
])

Neighborhood.delete_all()
Neighborhood.create([               
{ :name => 'Bainbridge Island',         :latitude => 47.629244, :longitude => -122.507858}, 
{ :name => 'Ballard',                   :latitude => 47.683997, :longitude => -122.381086}, 
{ :name => 'Beacon Hill',               :latitude => 47.588626, :longitude => -122.309246}, 
{ :name => 'Bellevue',                  :latitude => 47.609805, :longitude => -122.201271}, 
{ :name => 'Belltown',                  :latitude => 47.614360, :longitude => -122.3438686}, 
{ :name => 'Bothell',                   :latitude => 47.761107, :longitude => -122.205563}, 
{ :name => 'Boulevard Park',            :latitude => 47.503398, :longitude => -122.3094913}, 
{ :name => 'Burien',                    :latitude => 47.469816, :longitude => -122.343750}, 
{ :name => 'Capitol Hill',              :latitude => 47.632429, :longitude => -122.312078}, 
{ :name => 'Central District',          :latitude => 47.607668, :longitude => -122.306328}, 
{ :name => 'Columbia City',             :latitude => 47.559866, :longitude => -122.2864991}, 
{ :name => 'Delridge',                  :latitude => 47.552634, :longitude => -122.382545}, 
{ :name => 'Downtown',                  :latitude => 47.618777, :longitude => -122.33139}, 
{ :name => 'Edmonds',                   :latitude => 47.810011, :longitude => -122.373104}, 
{ :name => 'First Hill',                :latitude => 47.609438, :longitude => -122.3232908}, 
{ :name => 'Fremont',                   :latitude => 47.665792, :longitude => -122.351303}, 
{ :name => 'Georgetown',                :latitude => 47.559847, :longitude => -122.324181}, 
{ :name => 'Green Lake',                :latitude => 47.698325, :longitude => -122.324696}, 
{ :name => 'Greenwood',                 :latitude => 47.704910, :longitude => -122.35199}, 
{ :name => 'International District',    :latitude => 47.606742, :longitude => -122.319803}, 
{ :name => 'Issaquah',                  :latitude => 47.530101, :longitude => -122.0326191}, 
{ :name => 'Kirkland',                  :latitude => 47.681770, :longitude => -122.209682}, 
{ :name => 'Lake City',                 :latitude => 47.725411, :longitude => -122.278776}, 
{ :name => 'Lake Union',                :latitude => 47.632020, :longitude => -122.334137}, 
{ :name => 'Leschi',                    :latitude => 47.608362, :longitude => -122.288647}, 
{ :name => 'Lynnwood',                  :latitude => 47.821423, :longitude => -122.313709}, 
{ :name => 'Madison Park',              :latitude => 47.642781, :longitude => -122.284098}, 
{ :name => 'Madrona',                   :latitude => 47.616058, :longitude => -122.289419}, 
{ :name => 'Magnolia',                  :latitude => 47.656658, :longitude => -122.393961}, 
{ :name => 'Maple Leaf',                :latitude => 47.705603, :longitude => -122.314825}, 
{ :name => 'Mercer Island',             :latitude => 47.570210, :longitude => -122.221184}, 
{ :name => 'Northgate',                 :latitude => 47.720214, :longitude => -122.315083}, 
{ :name => 'Phinney Ridge',             :latitude => 47.670868, :longitude => -122.351618}, 
{ :name => 'Queen Anne',                :latitude => 47.635321, :longitude => -122.365036}, 
{ :name => 'Rainier Beach',             :latitude => 47.517518, :longitude => -122.256374}, 
{ :name => 'Rainier Valley',            :latitude => 47.567261, :longitude => -122.27972}, 
{ :name => 'Ravenna',                   :latitude => 47.683823, :longitude => -122.296371}, 
{ :name => 'Redmond',                   :latitude => 47.674805, :longitude => -122.117844}, 
{ :name => 'Renton',                    :latitude => 47.483971, :longitude => -122.216034}, 
{ :name => 'Sammamish',                 :latitude => 47.642662, :longitude => -122.066689}, 
{ :name => 'Sand Point',                :latitude => 47.678692, :longitude => -122.257048}, 
{ :name => 'Shoreline',                 :latitude => 47.755221, :longitude => -122.340832}, 
{ :name => 'South Park',                :latitude => 47.534472, :longitude => -122.310705}, 
{ :name => 'South Whidbey Island',      :latitude => 47.998276, :longitude => -122.439503}, 
{ :name => 'Tukwila',                   :latitude => 47.475618, :longitude => -122.262383}, 
{ :name => 'University District',       :latitude => 47.657698, :longitude => -122.306368}, 
{ :name => 'Wallingford',               :latitude => 47.655526, :longitude => -122.326796}, 
{ :name => 'Wedgwood',                  :latitude => 47.686669, :longitude => -122.294891}, 
{ :name => 'West Seattle',              :latitude => 47.576526, :longitude => -122.391901}, 
{ :name => 'White Center',              :latitude => 47.516675, :longitude => -122.354736} 
])




# Test data for development
if Rails.env.development?
    Random.new
    unconfirmed_user = FactoryGirl.create(:unconfirmed_user)
    confirmed_user = FactoryGirl.create(:confirmed_user)
    tech_user = FactoryGirl.create(:tech_user)
    Event.delete_all()
    FactoryGirl.create_list(:event, 15, :in_one_week, :creator_id => tech_user.id)
end