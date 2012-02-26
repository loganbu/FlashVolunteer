class Org < ActiveRecord::Base
    has_and_belongs_to_many :admins, :class_name => "User", :join_table => "orgs_admins", :uniq => true
    has_and_belongs_to_many :followers, :class_name => "User", :join_table => "orgs_followers", :uniq => true
end
