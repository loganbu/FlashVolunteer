class AddOffsetToSkills < ActiveRecord::Migration
  def change
    change_table :skills do |t|
        t.integer :offset
    end
  end
end
