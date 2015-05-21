class CreateSolarPanels < ActiveRecord::Migration
  def change
    create_table :solar_panels do |t|
      t.date :production_date
      t.date :expire_date
      t.float :height
      t.float :width
      t.float :power
      t.string :type
      t.string :subtype
      t.float :price
      t.integer :serialNo
      t.references :container, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
