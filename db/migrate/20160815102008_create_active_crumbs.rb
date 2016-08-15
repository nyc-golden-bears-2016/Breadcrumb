class CreateActiveCrumbs < ActiveRecord::Migration[5.0]
  def change
    create_table :active_crumbs do |t|
      t.boolean :reached, default: false
      t.string :entered_answer, default: nil
      t.integer :active_id
      t.integer :crumb_id
      t.integer :order_number

      t.timestamps
    end
  end
end
