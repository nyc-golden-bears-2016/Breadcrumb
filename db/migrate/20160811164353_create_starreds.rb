class CreateStarreds < ActiveRecord::Migration[5.0]
  def change
    create_table :starreds do |t|
      t.integer :trail_id
      t.integer :follower_id
      
      t.timestamps
    end
  end
end
