class CreateBuyerPhones < ActiveRecord::Migration
  def change
    create_table :buyer_phones do |t|
      t.references :buyer, index: true, foreign_key: true
      t.string :phone

      t.timestamps null: false
    end
  end
end
