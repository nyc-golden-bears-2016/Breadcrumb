class CreateTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :trails do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.boolean :priv, default: false
      t.boolean :sequential, default: true
      t.boolean :published, default: false
      t.integer :creator_id, foreign_key: true
      t.string :password, default: nil
      t.string :trail_image

      t.timestamps
    end
  end
end
