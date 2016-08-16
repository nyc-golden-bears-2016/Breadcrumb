class AddImgToUsers < ActiveRecord::Migration[5.0]
    def self.up
      add_attachment :users, :img
    end

    def self.down
      remove_attachment :users, :img
    end
end
