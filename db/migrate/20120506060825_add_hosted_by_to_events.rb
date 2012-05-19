class AddHostedByToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hosted_by, :string
  end
end
