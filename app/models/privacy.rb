class Privacy < ActiveRecord::Base
    belongs_to :user
    classy_enum_attr :upcoming_events, :enum => :privacy_level
end