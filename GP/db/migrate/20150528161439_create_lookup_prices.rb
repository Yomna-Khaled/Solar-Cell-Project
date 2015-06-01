class CreateLookupPrices < ActiveRecord::Migration
  def change
    create_table :lookup_prices do |t|
      t.string :name
      t.float :value

      t.timestamps null: false
    end
  end
end
