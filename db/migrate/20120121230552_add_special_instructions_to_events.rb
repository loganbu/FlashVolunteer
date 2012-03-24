class AddSpecialInstructionsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :special_instructions, :text
  end
end
