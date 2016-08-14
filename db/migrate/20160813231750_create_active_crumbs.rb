class CreateActiveCrumbs < ActiveRecord::Migration[5.0]
  def change
    create_table :active_crumbs do |t|
        t.integer :active_id, null: false

        t.timestamps
      end
  end
end
