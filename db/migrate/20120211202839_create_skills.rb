class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
    end
  end
end
