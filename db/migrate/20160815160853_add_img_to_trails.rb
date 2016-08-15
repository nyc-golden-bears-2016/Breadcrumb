class AddImgToTrails < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :trails, :img
  end

  def self.down
    remove_attachment :trails, :img
  end
end
