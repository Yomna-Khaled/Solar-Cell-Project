class RemoveVendorIdFromVendorMachines < ActiveRecord::Migration
  def change
    remove_column :vendor_machines, :vendor_id, :integer
  end
end
