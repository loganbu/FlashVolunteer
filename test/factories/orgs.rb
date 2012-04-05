FactoryGirl.define do 
    factory :org, :class => Org, :parent => :user do
            email       "flash@localhost.com"
            name        "flash volunteer"
            confirmed_at  DateTime.now
    end
end