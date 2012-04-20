class AddIdToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :id, :primary_key
  end
end
