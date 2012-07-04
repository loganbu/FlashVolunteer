class AddHelpArticlesToSearch < ActiveRecord::Migration
  def change
  	add_column :searches, :help_articles_found, :integer, :default => 0
  end
end
