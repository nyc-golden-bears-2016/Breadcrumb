class CreateTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :trails do |t|
      t.string :name, null: false
      t.text :description
      t.string :media_link_1
      t.string :media_link_2
      t.float :latitude
      t.float :longitude
      t.boolean :private, default: false
      t.boolean :sequential, default: false
      t.boolean :published, default: false
      t.integer :creator_id, foreign_key: true
      t.string :password, default: nil

      t.timestamps
    end
  end
end
