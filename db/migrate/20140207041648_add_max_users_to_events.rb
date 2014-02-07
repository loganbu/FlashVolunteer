class AddMaxUsersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_users, :integer
  end
end
