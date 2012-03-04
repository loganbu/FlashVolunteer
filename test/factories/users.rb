require "#{File.dirname(__FILE__)}/helpers/factory_helper"

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
        end
    end
end