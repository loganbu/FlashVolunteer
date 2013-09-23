class NotSameUserValidator < ActiveModel::Validator
  def validate(record)
    if record.giver == record.receiver
      record.errors[:base] << 'You cannot give yourself props'
    end
  end
end

class Prop < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with NotSameUserValidator
  validates_presence_of :giver, :message => 'Error giving props'
  validates_presence_of :receiver, :message => 'Error giving props'
  belongs_to :giver, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :receiver, :message

  scope :given_by, lambda { |person|
    where('giver_id = ?', person)
  }

  scope :received_by, lambda { |person|
    where('receiver_id = ?', person)
  }
end