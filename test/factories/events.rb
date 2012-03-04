FactoryGirl.define do
    factory :event do
        name            "Some default event name"
        description     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod scelerisque justo et viverra. Vestibulum pretium luctus ligula et venenatis. Cras vitae metus erat, vitae varius libero. Fusce mattis neque quis metus tempor ut vulputate odio mattis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean dapibus convallis sem, eu consequat eros scelerisque sit amet. Curabitur vestibulum ultricies nulla sed fermentum. Curabitur sit amet neque vitae erat tincidunt aliquet vel vitae nisi. Quisque ac mauris non est facilisis commodo ac at orci. Fusce posuere euismod aliquam. Pellentesque varius cursus bibendum. In dapibus velit id velit adipiscing ultricies. Duis malesuada rhoncus lorem, consequat luctus tellus pulvinar nec. Ut et arcu sed ligula pulvinar imperdiet. Nulla a sodales felis. Donec ultricies massa nec orci congue feugiat."
        self.end        { start + 1.hour }
        creator_id      { User.find_by_email("admin@localhost.com").id }


        trait :one_week_old do
            start   DateTime.now - 1.week
        end

        trait :in_one_week do
            start   DateTime.now + 1.week
        end

        trait :in_belltown do
            street          "2900 1st Ave"
            neighborhood    { Neighborhood.find_by_name("Belltown") }
            zip             98121
        end

        trait :in_wallingford do
            street          "2101 N Northlake Way"
            neighborhood    { Neighborhood.find_by_name("Wallingford")} 
            zip             98103
        end
        
    end
end
