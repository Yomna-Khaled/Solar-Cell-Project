class RemoveMachineIdFromVendorMachines < ActiveRecord::Migration
  def change
    remove_column :vendor_machines, :machine_id, :integer
  end
end
