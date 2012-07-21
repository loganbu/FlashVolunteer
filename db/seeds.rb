# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   Mayor.create(:name => 'Daley', :city => cities.first)

require "#{File.dirname(__FILE__)}/seeds_helper.rb"

Role.delete_all()
Role.create([
{ :name => "SuperAdmin" },
{ :name => "Volunteer" },
])

User.delete_all()
email = ENV['ADMIN_USERNAME'] && ENV['ADMIN_USERNAME'].dup
admin = User.find_or_create_by_email(:email => email || "admin@localhost.com", :password => ENV['ADMIN_PASSWORD'], :password_confirmation => ENV['ADMIN_PASSWORD'], :name=>"Admin")
admin.roles << Role.find_by_name("SuperAdmin")

Skill.delete_all()
Skill.create([
{ :name => "Advocacy | Human Rights",           :offset => 0 },
{ :name => "Animals",                           :offset => 1 },
{ :name => "Arts | Culture",                    :offset => 2 },
{ :name => "Children | Families",               :offset => 3 },
{ :name => "Community",                         :offset => 4 },
{ :name => "Computers | Technology",            :offset => 5 },
{ :name => "Disabilities | Elderly",            :offset => 6 },
{ :name => "Disaster Relief",                   :offset => 7 },
{ :name => "Education | Literacy",              :offset => 8 },
{ :name => "Environment",                       :offset => 9 },
{ :name => "GLBT",   							:offset => 10 },
{ :name => "Health | Medicine",                 :offset => 11 },
{ :name => "Homelessness | Housing",            :offset => 12 },
{ :name => "Hunger",                            :offset => 13 },
{ :name => "Immigrants | Refugees",             :offset => 14 },
{ :name => "Justice | Legal",                   :offset => 15 },
{ :name => "Media | Broadcasting",              :offset => 16 },
{ :name => "Politics",                          :offset => 17 },
{ :name => "Sports | Recreation",               :offset => 18 }
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
{ :name => 'Downtown Seattle',          :latitude => 47.618777, :longitude => -122.33139}, 
{ :name => "Des Moines",                :latitude => 47.407810, :longitude => -122.319892},
{ :name => 'Edmonds',                   :latitude => 47.810011, :longitude => -122.373104}, 
{ :name => "Federal Way",               :latitude => 47.300800, :longitude => -122.329460},
{ :name => 'First Hill',                :latitude => 47.609438, :longitude => -122.3232908}, 
{ :name => 'Fremont',                   :latitude => 47.665792, :longitude => -122.351303}, 
{ :name => 'Georgetown',                :latitude => 47.559847, :longitude => -122.324181}, 
{ :name => 'Green Lake',                :latitude => 47.698325, :longitude => -122.324696}, 
{ :name => 'Greenwood',                 :latitude => 47.704910, :longitude => -122.35199}, 
{ :name => 'International District',    :latitude => 47.606742, :longitude => -122.319803}, 
{ :name => 'Issaquah',                  :latitude => 47.530101, :longitude => -122.0326191}, 
{ :name => 'Kent',                      :latitude => 47.380279, :longitude => -122.237419}, 
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
{ :name => 'Mountlake Terrace',         :latitude => 47.788028, :longitude => -122.311111}, 
{ :name => 'Northgate',                 :latitude => 47.720214, :longitude => -122.315083}, 
{ :name => 'Phinney Ridge',             :latitude => 47.670868, :longitude => -122.351618}, 
{ :name => 'Pioneer Square',            :latitude => 47.601692, :longitude => -122.332305},
{ :name => 'Queen Anne',                :latitude => 47.635321, :longitude => -122.365036}, 
{ :name => 'Rainier Beach',             :latitude => 47.517518, :longitude => -122.256374}, 
{ :name => 'Rainier Valley',            :latitude => 47.567261, :longitude => -122.27972}, 
{ :name => 'Ravenna',                   :latitude => 47.683823, :longitude => -122.296371}, 
{ :name => 'Redmond',                   :latitude => 47.674805, :longitude => -122.117844}, 
{ :name => 'Renton',                    :latitude => 47.483971, :longitude => -122.216034}, 
{ :name => 'Roosevelt',                 :latitude => 47.680877, :longitude => -122.317115}, 
{ :name => 'Sammamish',                 :latitude => 47.642662, :longitude => -122.066689}, 
{ :name => 'Sand Point',                :latitude => 47.678692, :longitude => -122.257048}, 
{ :name => 'Seatac',                    :latitude => 47.434059, :longitude => -122.274261}, 
{ :name => 'Shoreline',                 :latitude => 47.755221, :longitude => -122.340832}, 
{ :name => 'South Park',                :latitude => 47.534472, :longitude => -122.310705}, 
{ :name => 'Whidbey Island',            :latitude => 47.998276, :longitude => -122.439503}, 
{ :name => 'Tukwila',                   :latitude => 47.475618, :longitude => -122.262383}, 
{ :name => 'University District',       :latitude => 47.657698, :longitude => -122.306368}, 
{ :name => 'Wallingford',               :latitude => 47.655526, :longitude => -122.326796}, 
{ :name => 'Wedgewood',                  :latitude => 47.686669, :longitude => -122.294891}, 
{ :name => 'West Seattle',              :latitude => 47.576526, :longitude => -122.391901}, 
{ :name => 'White Center',              :latitude => 47.516675, :longitude => -122.354736} 
])

Notification.delete_all
Notification.create([
{:name => "prop_received", :description=>"Props from a grateful Flash Volunteer"},
{:name => "new_event_attendee", :description=>"Someone signs up for an event I'm coordinating"},
{:name => "organizer_broadcast", :description=>"An event organizer wishes to contact me about an event I'm signed up for"}
])

$sample_event_names = [
{:name => "Fremont Fair"},
{:name => "Treehouse Wearhouse"},
{:name => "Collecting New & Gently Used Items for Benefit Sale"},
{:name => "Kirkland Boys & Girls Club Summer Dreams Auction"},
{:name => "Hopelink 40th Anniversary Gala"},
{:name => "Mercer Island Farmers Market Benefit Dinner - For the LOVE of Food"},
{:name => "Boys & Girls Club, SMART Girls Program"},
{:name => "FREE Electronic Recycling with CRISTA Ministries and Friendly Earth"},
{:name => "North King County Little League Mid Season Party"},
{:name => "Study Zone at the Shoreline Library"},
{:name => "Neighborhood House annual breakfast"},
{:name => "Neighborhood House annual breakfast"},
{:name => "Stuff the Bus at Street Fair"},
{:name => "Flash Volunteer Spring Reception"},
{:name => "Pioneer Square Spring Clean"},
{:name => "Seattle Summer Streets - Alki Beach"},
{:name => "Leaping for Literacy!"},
{:name => "Rock n Roll Seattle Marathon & Half Marathon benefiting the American Cancer Society"},
{:name => "Green Seattle Partnership Forest Monitoring Team"},
{:name => "Furry 5K"},
{:name => "Fremont Solstice Parade seeks Volunteers for Saturday, June 16th"},
{:name => "South Seattle Summer Meal Volunteer Event"},
{:name => "Celebrate Little Saigon"},
{:name => "Des Moines Summer Meal Volunteer Opportunity"},
{:name => "Federal Way Summer Meals Volunteer Opportunity"},
{:name => "Big Time Weeding"},
{:name => "More Maintaince on the Burke"},
{:name => "Youth Engagement Training"},
{:name => "Yet More Weeding"},
{:name => "Cleaning up the Burke"},
{:name => "Mulching galore!"},
{:name => "Fun with wood chips"},
{:name => "March with Pride!"},
{:name => "Clean up Alki Beach Park"},
{:name => "ESL classes and Citizenship Tutoring"},
{:name => "Help Out At The Wedgwood Arts Fest!"},
{:name => "Help Provide Food For Those In Need!"},
{:name => "A Summer Evening At Magnuson Children's Garden"},
{:name => "Happily Lend A Hand To The Heron Habitat Helpers"},
{:name => "Volunteer At The Braille Library"},
{:name => "Fight Hunger At The Family 4th!"},
{:name => "Help Provide Food For Those In Need!"},
{:name => "Have A Laptop? Want To Help Teens? Work With CHOICES!"},
{:name => "Stuff The Bus Takes On Seward Park"},
{:name => "Fourth on the Plateau"},
{:name => "Volunteer at Sammamish Landing"},
{:name => "Summer Meals Prep"},
{:name => "Bridge To Basics Call Nights: Connect Community Members With Important Benefits!"},
{:name => "Start Your Day With Yoga For Hope!"},
{:name => "2012 BAM ARTSfair!"},
{:name => "5K Run In Safeco Field"},
{:name => "Outdoor Cinema @ Magnuson & Marymoor Parks"},
{:name => "Be a Summer Camp Volunteer"},
{:name => "Redmond Bicycle Derby Days"},
{:name => "Outdoor Work Party Campus Ground Clean-up!"},
{:name => "Garden Of Goo - Native Plant Nursery"},
{:name => "Ivy and blackberry removal"},
{:name => "Clean Up Forest Remnant Zone"},
{:name => "Weed a planted area"},
{:name => "Kiwanis Wildlife Corridor"},
{:name => "Wood chips-adding buld to mycellium diets"}]

# Test data for development
if Rails.env.development?
    Random.new
    Org.delete_all()
    Event.delete_all()

    config = YAML::load(ERB.new(File.read("#{Rails.root}/db/seed.yml")).result)

    users = User.create(config["users"])
    users.each do |u|
        u.neighborhood = Neighborhood.all.sample
        u.save
    end

    $sample_event_names.each do |e|
        event = Event.new
        event.name = e[:name]
        neighborhood_info = random_neighborhood
        possible_participants = User.all
        event.start = Time.now + about_a_month
        event.user = possible_participants.delete(possible_participants.sample)
        event.end = event.start + Random.rand(1..5)
        event.description = random_description
        event.participants = possible_participants.sample(Random.rand(0..possible_participants.count))
        event.skills = Skill.all.sample(Random.rand(1..10))
        event.neighborhood = Neighborhood.find_by_name(neighborhood_info["name"])
        event.zip = neighborhood_info["zip"]
        event.street = neighborhood_info["address"]

        event.save!
    end
end