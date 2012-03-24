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
            Hash["name" => "Bainbridge Island", "zip" => 98110, "address"=>"210 Winslow Way E"],
            Hash["name" => "Ballard",           "zip" => 98107, "address"=>"2026 NW Market Street"],
            Hash["name" => "Beacon Hill",       "zip" => 98144, "address"=>"2533 16th Ave S"], 
            Hash["name" => "Bellevue",          "zip" => 98004, "address"=>"1086 Bellevue Square"],
            Hash["name" => "Belltown",          "zip" => 98121, "address"=>"90 Blanchard Street"],
            Hash["name" => "Bothell",           "zip" => 98012, "address"=>"1912 201st Pl SE"],
            Hash["name" => "Burien",            "zip" => 98148, "address"=>"15026 1st Ave S"], 
            Hash["name" => "Capitol Hill",      "zip" => 98122, "address"=>"619 E Pine Street"],
            Hash["name" => "Central District",  "zip" => 98122, "address"=>"1404 E Yesler Way"],
            Hash["name" => "Columbia City",     "zip" => 98118, "address"=>"4865 Rainier Ave S"],
            Hash["name" => "Delridge",          "zip" => 98106, "address"=>"3861 Delridge Way SW"],
            Hash["name" => "Downtown",          "zip" => 98101, "address"=>"1420 5th Ave"],
            Hash["name" => "Edmonds",           "zip" => 98020, "address"=>"111 5th Ave S"],
            Hash["name" => "First Hill",        "zip" => 98104, "address"=>"901 Madison Street"],
            Hash["name" => "Fremont",           "zip" => 98103, "address"=>"459 N 36th Street"],
            Hash["name" => "Georgetown",        "zip" => 98108, "address"=>"5200 Denver Ave S"],
            Hash["name" => "Green Lake",        "zip" => 98115, "address"=>"7200 E Green Lake Drive N"],
            Hash["name" => "Greenwood",         "zip" => 98103, "address"=>"8414 Greenwood Ave N"],
            Hash["name" => "International District",  "zip" => 98104, "address"=>"801 S Lane Street"],
            Hash["name" => "Issaquah",          "zip" => 98027, "address"=>"1580 NW Gilman Blvd"],
            Hash["name" => "Kirkland",          "zip" => 98033, "address"=>"350 Kirkland Avenue"], 
            Hash["name" => "Lake City",         "zip" => 98125, "address"=>"12336 Lake City Way NE"],
            Hash["name" => "Lake Union",        "zip" => 98102, "address"=>"11 E Allison Street"],
            Hash["name" => "Leschi",            "zip" => 98127, "address"=>"201 Lakeside Ave S"],
            Hash["name" => "Lynnwood",          "zip" => 98036, "address"=>"3711 196th Street SW"],
            Hash["name" => "Madison Park",      "zip" => 98112, "address"=>"4000 E Madison Street"],
            Hash["name" => "Madrona",           "zip" => 98122, "address"=>"1138 34th Avenue"],
            Hash["name" => "Magnolia",          "zip" => 98199, "address"=>"3830 34th Ave W"],
            Hash["name" => "Maple Leaf",        "zip" => 98115, "address"=>"8929 Roosevelt Way NE"],
            Hash["name" => "Mercer Island",     "zip" => 98040, "address"=>"3006 78th Ave SE"],
            Hash["name" => "Northgate",         "zip" => 98125, "address"=>"301 NE 103rd Street"],
            Hash["name" => "Phinney Ridge",     "zip" => 98103, "address"=>"6412 Phinney Ave N"],
            Hash["name" => "Queen Anne",        "zip" => 98109, "address"=>"2121 Queen Anne Ave N"],
            Hash["name" => "Rainier Beach",     "zip" => 98118, "address"=>"8825 Rainier Ave S"],
            Hash["name" => "Rainier Valley",    "zip" => 98118, "address"=>"4205 Rainier Ave S"],
            Hash["name" => "Ravenna",           "zip" => 98105, "address"=>"5520 Ravenna Ave NE"],
            Hash["name" => "Redmond",           "zip" => 98052, "address"=>"1 Microsoft Way"],
            Hash["name" => "Renton",            "zip" => 98057, "address"=>"724 S 3rd Street"],
            Hash["name" => "Sammamish",         "zip" => 98074, "address"=>"22830 NE 8th Street"],
            Hash["name" => "Sand Point",        "zip" => 98105, "address"=>"5412 Sand Point Way NE"],
            Hash["name" => "Shoreline",         "zip" => 98133, "address"=>"15544 Aurora Ave N"],
            Hash["name" => "South Park",        "zip" => 98108, "address"=>"8201 10th Ave S"],
            Hash["name" => "Tukwila",           "zip" => 98168, "address"=>"12424 42nd Ave S"],
            Hash["name" => "University District","zip" => 98105, "address"=>"4518 University Way NE"],
            Hash["name" => "Wallingford",       "zip" => 98103, "address"=>"2101 N Northlake Way"],
            Hash["name" => "Wedgwood",          "zip" => 98115, "address"=>"8230 35th Ave NE"],
            Hash["name" => "West Seattle",      "zip" => 98116, "address"=>"3407 California Ave SW"],
            Hash["name" => "Whidbey Island",    "zip" => 98260, "address"=>"5237 Langley Road"],
            Hash["name" => "White Center",      "zip" => 98146, "address"=>"10829 8th Ave SW"],
                            ]


def random_neighborhood
    $neighborhoods_with_addresses[Random.rand($neighborhoods_with_addresses.length)]
end

def random_skills
    Skill.find(:all, :order => 'random()', :limit=> Random.rand(5)+1)
end

$description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod scelerisque justo et viverra. Vestibulum pretium luctus ligula et venenatis. Cras vitae metus erat, vitae varius libero. Fusce mattis neque quis metus tempor ut vulputate odio mattis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean dapibus convallis sem, eu consequat eros scelerisque sit amet. Curabitur vestibulum ultricies nulla sed fermentum. Curabitur sit amet neque vitae erat tincidunt aliquet vel vitae nisi. Quisque ac mauris non est facilisis commodo ac at orci. Fusce posuere euismod aliquam. Pellentesque varius cursus bibendum. In dapibus velit id velit adipiscing ultricies. Duis malesuada rhoncus lorem, consequat luctus tellus pulvinar nec. Ut et arcu sed ligula pulvinar imperdiet. Nulla a sodales felis. Donec ultricies massa nec orci congue feugiat."
$descriptions = [
    $description,
    $description[0..($description.length/2)],
    $description[($description.length/2)..($description.length-1)],
    "Really short description"
]
def random_description
    $descriptions[Random.rand($descriptions.length)]
end