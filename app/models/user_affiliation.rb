class UserAffiliation < ActiveRecord::Base
  belongs_to :user
  belongs_to :affiliate
end
