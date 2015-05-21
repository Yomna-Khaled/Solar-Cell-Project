class CreateSpareParts < ActiveRecord::Migration
  def change
    create_table :spare_parts do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.references :material, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
