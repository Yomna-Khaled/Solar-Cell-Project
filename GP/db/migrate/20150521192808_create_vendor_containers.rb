class CreateVendorContainers < ActiveRecord::Migration
  def change
    create_table :vendor_containers do |t|
      t.references :vendor, index: true, foreign_key: true
      t.references :container, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
  end
end
