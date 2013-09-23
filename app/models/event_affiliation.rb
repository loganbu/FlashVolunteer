class EventAffiliation < ActiveRecord::Base
  belongs_to :event
  belongs_to :affiliate
end
