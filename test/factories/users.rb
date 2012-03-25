require "#{File.dirname(__FILE__)}/helpers/factory_helper"

def add_random_skills_info(e)
    e.skills = random_skills
end

def add_random_neighborhood_info_to_user(e)
    this_address_hash = random_neighborhood
    e.neighborhood    = Neighborhood.find_by_name(this_address_hash["name"])
end

FactoryGirl.define do 
    factory :user do
        password      ENV['ADMIN_PASSWORD']

        factory :confirmed_user do
            email         "confirmed@localhost.com"
            name          "Confirmed user"
            confirmed_at  DateTime.now
        end

        factory :unconfirmed_user do
            email         "unconfirmed@localhost.com"
            name          "Unconfirmed user"
        end

        factory :tech_user do
            email         "techuser@localhost.com"
            name          "Techy Person"

            after_build do |e|
                add_random_neighborhood_info_to_user(e)
                add_random_skills_info(e)
                e.save!
            end
        end
        
        factory :org_admin do
            email       "brad@localhost.com"
            name        "brad wilke"
        end
    end
end