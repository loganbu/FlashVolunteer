class AddVmEvents < ActiveRecord::Migration
  def change
    create_table :volunteer_matches do |t|
      t.integer :vm_id
      t.boolean :imported, :default => false
      t.boolean :allow_group_invitations
      t.boolean :allow_group_reservation
      t.datetime :start_time
      t.datetime :end_time
      t.integer :beneficiary
      t.string :category_ids
      t.string :contact_email
      t.string :contact_name
      t.string :contact_phone
      t.datetime :created
      t.text :description
      t.string :great_for
      t.boolean :has_wait_list
      t.string :image_url
      t.integer :minimum_age
      t.integer :num_referred
      t.boolean :requires_address
      t.text :requirements
      t.text :skills_needed
      t.integer :spaces_available
      t.string :status
      t.string :tags
      t.string :title
      t.boolean :virtual
      t.string :vm_url
      t.integer :volunteers_needed

      # Cache geocode info
      t.boolean :reverse_geocoded, :default => false
      t.string :street
      t.string :neighborhood_string
      t.string :city
      t.string :zip
      t.string :state
      t.float :latitude
      t.float :longitude
    end

    create_table :volunteer_match_metadata do |t|

    end

    add_column :events, :vm_id, :integer, :default => 0
  end
end
