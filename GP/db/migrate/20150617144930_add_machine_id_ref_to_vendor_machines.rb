class AddMachineIdRefToVendorMachines < ActiveRecord::Migration
  def change
    add_reference :vendor_machines, :machine, index: true, foreign_key: true
  end
end
