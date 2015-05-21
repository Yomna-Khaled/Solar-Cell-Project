class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.float :width
      t.float :height
      t.string :serialNo
      t.integer :capacity
      t.float :price
      t.float :total_power

      t.timestamps null: false
    end
  end
end
