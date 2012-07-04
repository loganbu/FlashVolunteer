class MakeHelpDbDriven < ActiveRecord::Migration
  def change
  	create_table :help_articles do |t|
      t.string :title
      t.text :description
  	end
  end
end
