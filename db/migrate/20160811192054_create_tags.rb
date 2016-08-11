class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.integer :trail_id, null: false
      t.string :description, limit: 25

      t.timestamps
      end
    end
end
