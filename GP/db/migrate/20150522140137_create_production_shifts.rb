class CreateProductionShifts < ActiveRecord::Migration
  def change
    create_table :production_shifts do |t|
      t.references :material, index: true, foreign_key: true
      t.references :shift, index: true, foreign_key: true
      t.float :material_quantity

      t.timestamps null: false
    end
  end
end
