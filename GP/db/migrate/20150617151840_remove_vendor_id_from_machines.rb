class RemoveVendorIdFromMachines < ActiveRecord::Migration
  def change
	remove_column :machines, :vendor_id, :integer
  end
end
