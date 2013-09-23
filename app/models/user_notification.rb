class UserNotification < ActiveRecord::Base
  belongs_to :notification
  belongs_to :user
end
