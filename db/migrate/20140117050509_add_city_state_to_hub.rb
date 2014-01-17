class AddCityStateToHub < ActiveRecord::Migration
  def change
    add_column :hubs, :city_state, :string
  end
end
