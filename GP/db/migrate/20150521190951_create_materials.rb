class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.integer :Min_Number
      t.string :stockNo
      t.string :shelfNo
      t.date :production_date
      t.date :expiration_date
      t.references :quantity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
