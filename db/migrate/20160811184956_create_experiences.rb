class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.integer :user_id, null: false
      t.integer :trail_id, null: false
      t.boolean :completed, default: false
      t.integer :last_crumb_reached, default: 0
      t.boolean :winner, default: false

      t.timestamps
    end
  end
end
