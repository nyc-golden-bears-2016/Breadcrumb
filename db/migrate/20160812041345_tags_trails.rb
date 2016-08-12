class TagsTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :tags_trails do |t|
      t.integer :trail_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
