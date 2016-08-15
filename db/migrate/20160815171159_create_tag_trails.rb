class CreateTagTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_trails do |t|
      t.integer :trail_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
