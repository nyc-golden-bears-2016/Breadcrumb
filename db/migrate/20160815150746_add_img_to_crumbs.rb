class AddImgToCrumbs < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :crumbs, :img
  end

  def self.down
    remove_attachment :crumbs, :img
  end
end
