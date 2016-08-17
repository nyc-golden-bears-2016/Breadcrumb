class CreateCrumbs < ActiveRecord::Migration[5.0]
  def change
    create_table :crumbs do |t|
      t.string :name, null: false
      t.text :description
      t.float :latitude
      t.float :longitude
      t.boolean :requires_answer, default: false
      t.string :answer, default: nil
      t.string :question, default: nil
      t.integer :trail_id, null: false
      t.integer :order_number, default: nil

      t.timestamps
    end
  end
end
