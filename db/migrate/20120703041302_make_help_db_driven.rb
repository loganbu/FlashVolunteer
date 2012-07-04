class MakeHelpDbDriven < ActiveRecord::Migration
  def change
  	create_table :helps do |t|
      t.string :title
      t.text :description
  	end
  end
end
