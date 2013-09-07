class CreateHubs < ActiveRecord::Migration
  def up
    create_table :hubs do |t|
      t.point :center
      t.integer :zoom
      t.integer :radius
      t.string :name
    end
    config = YAML::load(ERB.new(File.read("#{Rails.root}/db/hubs.yml")).result)

    hubs = Hub.create(config["hubs"])
  end

  def down
    drop_table :hubs
  end
end
