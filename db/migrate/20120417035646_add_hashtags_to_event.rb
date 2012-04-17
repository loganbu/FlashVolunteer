class AddHashtagsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :twitter_hashtags, :string
  end
end
