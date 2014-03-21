class AddCityStateToHub < ActiveRecord::Migration
  def change
    add_column :hubs, :city_state, :string

    config = YAML::load(ERB.new(File.read("#{Rails.root}/db/hubs.yml")).result)

    Hub.create(config["hubs"])
  end
end
