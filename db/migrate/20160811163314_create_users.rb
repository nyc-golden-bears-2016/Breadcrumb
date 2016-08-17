class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.float :latitude, default: 40.706417
      t.float :longitude, default: -74.009082

      t.timestamps
    end
  end
end
