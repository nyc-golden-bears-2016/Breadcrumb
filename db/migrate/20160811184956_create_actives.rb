class CreateActives < ActiveRecord::Migration[5.0]
  def change
    create_table :actives do |t|
      t.integer :user_id, null: false
      t.integer :trail_id, null: false
      t.boolean :completed, default: false
      t.integer :last_crumb_reached, default: 1
      t.boolean :winner, default: false
      t.string :entered_password, default: nil

      t.timestamps
    end
  end
end
