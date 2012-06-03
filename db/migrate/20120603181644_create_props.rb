class CreateProps < ActiveRecord::Migration
  def change
    create_table :props do |t|
        t.belongs_to :giver, :class_name=>"User"
        t.belongs_to :receiver, :class_name=>"User"
        t.text :message
        t.timestamps
    end
  end
end
