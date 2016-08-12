class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :crumb_id, null: false
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
