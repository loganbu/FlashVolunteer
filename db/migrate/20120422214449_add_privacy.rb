class AddPrivacy < ActiveRecord::Migration
  def up
    create_table :privacies do |t|
        t.references :user
        t.string :upcoming_events, :default => 'everyone'
    end
  end

  def down
    drop_table :privacies
  end
end
