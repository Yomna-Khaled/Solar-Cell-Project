class CreateMaterialProperties < ActiveRecord::Migration
  def change
    create_table :material_properties do |t|
      t.references :material, index: true, foreign_key: true
      t.references :property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
