class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.integer :trail_id

      t.timestamps
    end
  end
end
