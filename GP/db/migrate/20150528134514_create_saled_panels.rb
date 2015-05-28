class CreateSaledPanels < ActiveRecord::Migration
  def change
    create_table :saled_panels do |t|
      t.references :solar_panel, index: true, foreign_key: true
      t.references :buyer, index: true, foreign_key: true
      t.float :totalPrice
      t.float :totalPower

      t.timestamps null: false
    end
  end
end
