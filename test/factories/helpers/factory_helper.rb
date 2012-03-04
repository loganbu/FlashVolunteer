def random_time(d)
    if d.kind_of? Range
        return (Random.rand(d.end-d.begin)+d.begin).days
    end
    return Random.rand(d).days
end

def about_a_week
    return random_time(5..9)
end

def about_a_month
    return random_time(25..35)
end

def about_six_months
    return random_time(160..200)
end


# Not all neighborhoods are represented.  As they are filled in, removed the commented lines.
$neighborhoods_with_addresses = [
#{ :name => 'Bainbridge Island',         :latitude => 47.629244, :longitude => -122.507858}, 
            Hash["name" => "Ballard",           "zip" => 98107, "address"=>"2026 NW Market Street"],
#{ :name => 'Beacon Hill',               :latitude => 47.588626, :longitude => -122.309246}, 
            Hash["name" => "Bellevue",          "zip" => 98004, "address"=>"1086 Bellevue Sq"],
            Hash["name" => "Belltown",          "zip" => 98121, "address"=>"90 Blanchard St"],
#{ :name => 'Belltown',                  :latitude => 47.614360, :longitude => -122.3438686}, 
#{ :name => 'Bothell',                   :latitude => 47.761107, :longitude => -122.205563}, 
#{ :name => 'Boulevard Park',            :latitude => 47.503398, :longitude => -122.3094913}, 
#{ :name => 'Burien',                    :latitude => 47.469816, :longitude => -122.343750}, 
            Hash["name" => "Capitol Hill",      "zip" => 98122, "address"=>"619 E Pine St"],
            Hash["name" => "Central District",  "zip" => 98122, "address"=>"1404 E Yesler Way"],
#{ :name => 'Columbia City',             :latitude => 47.559866, :longitude => -122.2864991}, 
#{ :name => 'Delridge',                  :latitude => 47.552634, :longitude => -122.382545}, 
#{ :name => 'Downtown',                  :latitude => 47.618777, :longitude => -122.33139}, 
#{ :name => 'Edmonds',                   :latitude => 47.810011, :longitude => -122.373104}, 
#{ :name => 'First Hill',                :latitude => 47.609438, :longitude => -122.3232908}, 
#{ :name => 'Fremont',                   :latitude => 47.665792, :longitude => -122.351303}, 
#{ :name => 'Georgetown',                :latitude => 47.559847, :longitude => -122.324181}, 
#{ :name => 'Green Lake',                :latitude => 47.698325, :longitude => -122.324696}, 
#{ :name => 'Greenwood',                 :latitude => 47.704910, :longitude => -122.35199}, 
#{ :name => 'International District',    :latitude => 47.606742, :longitude => -122.319803}, 
#{ :name => 'Issaquah',                  :latitude => 47.530101, :longitude => -122.0326191}, 
#{ :name => 'Kirkland',                  :latitude => 47.681770, :longitude => -122.209682}, 
#{ :name => 'Lake City',                 :latitude => 47.725411, :longitude => -122.278776}, 
#{ :name => 'Lake Union',                :latitude => 47.632020, :longitude => -122.334137}, 
#{ :name => 'Leschi',                    :latitude => 47.608362, :longitude => -122.288647}, 
#{ :name => 'Lynnwood',                  :latitude => 47.821423, :longitude => -122.313709}, 
#{ :name => 'Madison Park',              :latitude => 47.642781, :longitude => -122.284098}, 
#{ :name => 'Madrona',                   :latitude => 47.616058, :longitude => -122.289419}, 
#{ :name => 'Magnolia',                  :latitude => 47.656658, :longitude => -122.393961}, 
#{ :name => 'Maple Leaf',                :latitude => 47.705603, :longitude => -122.314825}, 
#{ :name => 'Mercer Island',             :latitude => 47.570210, :longitude => -122.221184}, 
#{ :name => 'Northgate',                 :latitude => 47.720214, :longitude => -122.315083}, 
#{ :name => 'Phinney Ridge',             :latitude => 47.670868, :longitude => -122.351618}, 
#{ :name => 'Queen Anne',                :latitude => 47.635321, :longitude => -122.365036}, 
#{ :name => 'Rainier Beach',             :latitude => 47.517518, :longitude => -122.256374}, 
#{ :name => 'Rainier Valley',            :latitude => 47.567261, :longitude => -122.27972}, 
#{ :name => 'Ravenna',                   :latitude => 47.683823, :longitude => -122.296371}, 
            Hash["name" => "Redmond",           "zip" => 98052, "address"=>"1 Microsoft Way"],
#{ :name => 'Renton',                    :latitude => 47.483971, :longitude => -122.216034}, 
#{ :name => 'Sammamish',                 :latitude => 47.642662, :longitude => -122.066689}, 
#{ :name => 'Sand Point',                :latitude => 47.678692, :longitude => -122.257048}, 
#{ :name => 'Shoreline',                 :latitude => 47.755221, :longitude => -122.340832}, 
#{ :name => 'South Park',                :latitude => 47.534472, :longitude => -122.310705}, 
#{ :name => 'South Whidbey Island',      :latitude => 47.998276, :longitude => -122.439503}, 
#{ :name => 'Tukwila',                   :latitude => 47.475618, :longitude => -122.262383}, 
#{ :name => 'University District',       :latitude => 47.657698, :longitude => -122.306368}, 
            Hash["name" => "University District","zip" => 98195, "address"=>"University of Washington"],
            Hash["name" => "Wallingford",       "zip" => 98103, "address"=>"2101 N Northlake Way"],
#{ :name => 'Wedgwood',                  :latitude => 47.686669, :longitude => -122.294891}, 
#{ :name => 'West Seattle',              :latitude => 47.576526, :longitude => -122.391901}, 
#{ :name => 'White Center',              :latitude => 47.516675, :longitude => -122.354736}
                            ]


def random_neighborhood
    $neighborhoods_with_addresses[Random.rand($neighborhoods_with_addresses.length)]
end

def random_skills
    Skill.find(:all, :order => 'random()', :limit=> Random.rand(5)+1)
end