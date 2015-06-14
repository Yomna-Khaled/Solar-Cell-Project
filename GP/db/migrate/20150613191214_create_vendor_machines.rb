class CreateVendorMachines < ActiveRecord::Migration
  def change
    create_table :vendor_machines do |t|
      t.integer :vendor_id
      t.integer :machine_id

      t.timestamps null: false
    end
  end
end
