require "#{File.dirname(__FILE__)}/helpers/factory_helper"

def add_random_neighborhood_info(e)
    this_address_hash = random_neighborhood
    e.street          = this_address_hash["address"]
    e.zip             = this_address_hash["zip"]
    e.neighborhood    = Neighborhood.find_by_name(this_address_hash["name"])
end

def add_random_skills_info(e)
    e.skills = random_skills
end

FactoryGirl.define do
    factory :event do
        name            "Some default event name"
        description     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod scelerisque justo et viverra. Vestibulum pretium luctus ligula et venenatis. Cras vitae metus erat, vitae varius libero. Fusce mattis neque quis metus tempor ut vulputate odio mattis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean dapibus convallis sem, eu consequat eros scelerisque sit amet. Curabitur vestibulum ultricies nulla sed fermentum. Curabitur sit amet neque vitae erat tincidunt aliquet vel vitae nisi. Quisque ac mauris non est facilisis commodo ac at orci. Fusce posuere euismod aliquam. Pellentesque varius cursus bibendum. In dapibus velit id velit adipiscing ultricies. Duis malesuada rhoncus lorem, consequat luctus tellus pulvinar nec. Ut et arcu sed ligula pulvinar imperdiet. Nulla a sodales felis. Donec ultricies massa nec orci congue feugiat."
        self.end        { start + 1.hour }
        creator_id      { User.find_by_email("admin@localhost.com").id }


        trait :one_week_old do
            start   DateTime.now - about_a_week
        end

        trait :in_one_week do
            start   DateTime.now + about_a_week
        end

        # This will populate street/zip/neibhorhood in the after_build
        after_build do |e|
            add_random_neighborhood_info(e)
            add_random_skills_info(e)
            e.save!
        end

    end
end
