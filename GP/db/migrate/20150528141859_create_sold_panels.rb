class CreateSoldPanels < ActiveRecord::Migration
  def change
    create_table :sold_panels do |t|
      t.references :buyer, index: true, foreign_key: true
      t.float :totalPrice
      t.float :totalPower

      t.timestamps null: false
    end
  end
end
