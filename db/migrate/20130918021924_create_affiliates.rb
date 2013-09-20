class CreateAffiliates < ActiveRecord::Migration
  def up
    create_table :affiliates do |t|
      t.attachment :logo
      t.string :name
      t.text :description
      t.text :notes
    end

    create_table :affiliate_users do |t|
      t.belongs_to :affiliate
      t.belongs_to :user
    end

    create_table :affiliate_events do |t|
      t.belongs_to :affiliate
      t.belongs_to :event
    end

    add_column :roles, :affiliate_id, :integer
    add_column :events, :private, :boolean

    am = Role.new(:name => 'AffiliateModerator')
    am.save!
  end

  def down
    drop_table :affiliates
    drop_table :affiliate_users
    drop_table :affiliate_events
    remove_column :roles, :affiliate_id
    remove_column :events, :private
    am = Role.find_by_name('AffiliateModerator')
    am.delete
  end
end