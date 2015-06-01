class CreateVendorSpares < ActiveRecord::Migration
  def change
    create_table :vendor_spares do |t|
      t.date :date
      t.references :vendor, index: true, foreign_key: true
      t.references :spare_part, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
