class CreateAffiliates < ActiveRecord::Migration
  def up
    create_table :affiliates do |t|
      t.attachment :logo
      t.string :name
      t.string :description
    end

    create_table :user_affiliations do |t|
      t.primary_key :id
      t.belongs_to :affiliate
      t.belongs_to :user
      t.boolean :moderator
    end

    create_table :event_affiliations do |t|
      t.primary_key :id
      t.belongs_to :affiliate
      t.belongs_to :event
    end

    add_column :events, :private, :boolean
  end

  def down
    drop_table :affiliates
    drop_table :user_affiliations
    drop_table :event_affiliations
    remove_column :events, :private
  end
end