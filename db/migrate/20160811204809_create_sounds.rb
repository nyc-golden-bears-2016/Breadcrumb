class CreateSounds < ActiveRecord::Migration[5.0]
  def change
    create_table :sounds do |t|
      t.integer :crumb_id, null: false
      
      t.timestamps
    end
  end
end
