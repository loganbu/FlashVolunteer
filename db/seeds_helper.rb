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
Hash["zip" => 98122, "address" => "832 32nd Avenue",                            "WKT" => "POINT (-122.291 47.6102)" ],
Hash["zip" => 98109, "address" => "The Studio 711 Sixth Avenue North, #200 ",   "WKT" => "POINT (-122.345 47.6201)" ],
Hash["zip" => 98126, "address" => "West Duwamish Greenbelt",                    "WKT" => "POINT (-122.352 47.5564)" ],
Hash["zip" => 98108, "address" => "West Duwamish Greenbelt ",                   "WKT" => "POINT (-122.352 47.5564)" ],
Hash["zip" => 98005, "address" => "900 Bellevue Way NE  ",                      "WKT" => "POINT (-122.201 47.6183)" ],
Hash["zip" => 98004, "address" => "Somewhere",                                  "WKT" => "POINT (-122.205 47.6265)" ],
Hash["zip" => 98121, "address" => "2211 Alaskan Way, Pier 66 ",                 "WKT" => "POINT (-122.35 47.6118)" ],
Hash["zip" => 98103, "address" => "6532 Phinney Ave N",                         "WKT" => "POINT (-122.354 47.6772)" ],
Hash["zip" => 98168, "address" => "3800 S 115th St  ",                          "WKT" => "POINT (-122.284 47.5008)" ],
Hash["zip" => 98178, "address" => "12535 50th Place S  ",                       "WKT" => "POINT (-122.27 47.491)" ],
Hash["zip" => 98106, "address" => "SW Dawson St  ",                             "WKT" => "POINT (-122.36 47.5574)" ],
Hash["zip" => 98126, "address" => "West Seattle ",                              "WKT" => "POINT (-122.374 47.5762)" ],
Hash["zip" => 98108, "address" => "7900 10th Ave S.",                           "WKT" => "POINT (-122.32 47.5315)" ],
Hash["zip" => 98106, "address" => "1901 SW Genesee St  ",                       "WKT" => "POINT (-122.358 47.5648)" ],
Hash["zip" => 98103, "address" => "Greenwood Senior Center, 525 N 85th St",     "WKT" => "POINT (-122.351 47.6904)" ],
Hash["zip" => 98109, "address" => "305 Harrison St ",                           "WKT" => "POINT (-122.351 47.621)" ],
Hash["zip" => 98004, "address" => "510 Bellevue Way NE  ",                      "WKT" => "POINT (-122.201 47.6153)" ],
Hash["zip" => 98110, "address" => "Pritchard Park on Bainbridge Island, WA  ",  "WKT" => "POINT (-122.521 47.6262)" ],
Hash["zip" => 98144, "address" => "9026 4th Ave S, Seattle, WA",                "WKT" => "POINT (-122.33 47.5227)" ],
Hash["zip" => 98122, "address" => "3639 MLK Jr. Way South ",                    "WKT" => "POINT (-120.74 47.7511)" ],
Hash["zip" => 98103, "address" => "Madrona Woods Lake Washington Blvd",         "WKT" => "POINT (-122.259 47.6095)" ],
Hash["zip" => 98101, "address" => "155 N 35th St  ",                            "WKT" => "POINT (-122.356 47.6518)" ],
Hash["zip" => 98101, "address" => "1830 9th Avenue",                            "WKT" => "POINT (-122.334 47.6151)" ],
Hash["zip" => 98057, "address" => "1107 SW Grady Way, Suite 130",               "WKT" => "POINT (-122.232 47.4678)" ],
Hash["zip" => 98025, "address" => "Taylor Mountain Forest Hwy-18",              "WKT" => "POINT (-122.017 47.4665)" ],
Hash["zip" => 98144, "address" => "2524 16th Avenue South",                     "WKT" => "POINT (-122.311 47.5802)" ],
Hash["zip" => 98116, "address" => "1702 Alki Ave. SW  ",                        "WKT" => "POINT (-122.411 47.5789)" ],
Hash["zip" => 98038, "address" => "Belmondo Reach Natural Area Hwy-169",        "WKT" => "POINT (-120.74 47.7511)" ],
Hash["zip" => 98108, "address" => "2820 South Orcas St., ",                     "WKT" => "POINT (-122.295 47.5525)" ],
Hash["zip" => 98168, "address" => "3800 S 115th St  ",                          "WKT" => "POINT (-122.284 47.5008)" ],
Hash["zip" => 98004, "address" => "4030 95th Ave NE  ",                         "WKT" => "POINT (-122.214 47.6466)" ],
Hash["zip" => 98144, "address" => "Mount Baker Community Center 2811",          "WKT" => "POINT (-122.288 47.5778)" ],
Hash["zip" => 98122, "address" => "Madrona k-8 1121 33rd Ave.",                 "WKT" => "POINT (-122.291 47.6126)" ],
Hash["zip" => 98040, "address" => "Island Crest Way & SE 68th St",              "WKT" => "POINT (-122.222 47.5421)" ],
Hash["zip" => 98144, "address" => "811 Mount Rainier Drive S. ",                "WKT" => "POINT (-120.74 47.7511)" ],
Hash["zip" => 98033, "address" => "12033 Northeast 80th Street ",               "WKT" => "POINT (-120.74 47.7511)" ],
Hash["zip" => 98033, "address" => "Redmond, WA",                                "WKT" => "POINT (-122.204 47.6706)" ],
Hash["zip" => 98004, "address" => "4030 95th Ave NE  ",                         "WKT" => "POINT (-122.214 47.6466)" ],
Hash["zip" => 98115, "address" => "4500 110th Avenue NE",                       "WKT" => "POINT (-122.194 47.6501)" ],
Hash["zip" => 98101, "address" => "1900 5th Ave  ",                             "WKT" => "POINT (-122.338 47.6138)" ]
                            ]

def random_neighborhood
    $neighborhoods_with_addresses.sample
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