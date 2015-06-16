class AddDateToVendorMachines < ActiveRecord::Migration
  def change
    add_column :vendor_machines, :date, :date
  end
end
