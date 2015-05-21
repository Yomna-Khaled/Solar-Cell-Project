class CreateVendorPhones < ActiveRecord::Migration
  def change
    create_table :vendor_phones do |t|
      t.references :vendor, index: true, foreign_key: true
      t.string :phone

      t.timestamps null: false
    end
  end
end
