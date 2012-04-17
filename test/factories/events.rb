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

def add_random_description(e)
    e.description = random_description
end

FactoryGirl.define do
    factory :event do
        name            "Lorem ipsum dolor sit amet"
        self.end        { start + 1.hour }
        creator_id      { User.find_by_email("admin@localhost.com").id }


        trait :one_week_old do
            start   DateTime.now - about_a_week
        end

        trait :in_one_week do
            start   DateTime.now + about_a_week
        end

        trait :in_one_month do
            start   DateTime.now + about_a_month
        end

        trait :in_two_months do
            start   DateTime.now + about_a_month + about_a_month
        end

        trait :one_month_old do
            start   DateTime.now - about_a_month
        end

        # This will populate street/zip/neibhorhood in the after_build
        after_build do |e|
            add_random_description(e)
            add_random_neighborhood_info(e)
            add_random_skills_info(e)
            e.save!
        end

    end
end
