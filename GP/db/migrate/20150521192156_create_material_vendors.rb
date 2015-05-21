class CreateMaterialVendors < ActiveRecord::Migration
  def change
    create_table :material_vendors do |t|
      t.references :vendor, index: true, foreign_key: true
      t.references :material, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
  end
end
