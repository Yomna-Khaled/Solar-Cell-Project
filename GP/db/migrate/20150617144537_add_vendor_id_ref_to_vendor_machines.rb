class AddVendorIdRefToVendorMachines < ActiveRecord::Migration
  def change
    add_reference :vendor_machines, :vendor, index: true, foreign_key: true
  end
end
