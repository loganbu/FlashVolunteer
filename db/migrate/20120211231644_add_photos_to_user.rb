class AddPhotosToUser < ActiveRecord::Migration
    def up
        change_table :users do |t|
            t.has_attached_file :avatar
        end
    end

    def down
        drop_attached_file :users, :avatar
    end
end
