class CreateAfgProvider < ActiveRecord::Migration
  def change
    create_table :afg_opportunities do |t|
      t.string :key
      t.boolean :imported, :default => false
      t.string :title
      t.string :latlong
      t.string :location_name
      t.datetime :startDate
      t.datetime :endDate
      t.string :sponsoringOrganizationName
      t.string :xml_url
      t.string :skills
      t.string :city
      t.text :description

      # Cache geocode info
      t.boolean :reverse_geocoded, :default => false
      t.string :street
      t.string :neighborhood_string
      t.string :zip
    end
  end
end
