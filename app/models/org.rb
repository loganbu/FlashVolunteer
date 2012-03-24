class Org < ActiveRecord::Base
    has_and_belongs_to_many :admins, :class_name => "User", :join_table => "orgs_admins", :uniq => true
    has_and_belongs_to_many :followers, :class_name => "User", :join_table => "orgs_followers", :uniq => true

    attr_accessible :mission, :name, :email, :website
    
    scope :has_admin, lambda { |user|
        includes(:admins).where("users.id = ?", user.id)
    }

    scope :has_follower, lambda { |user|
        includes(:followers).where("users.id = ?", user.id)
    }

    def email
        User.org_info(self).first().email
    end
    def email=(other)
        User.org_info(self).first().email = other
    end
    def name
        User.org_info(self).first().name
    end
    def name=(other)
        User.org_info(self).first().name = other
    end
    def avatar
        User.org_info(self).first.avatar
    end
    def avatar=(other)
        User.org_info(self).first().avatar = other
    end
end
