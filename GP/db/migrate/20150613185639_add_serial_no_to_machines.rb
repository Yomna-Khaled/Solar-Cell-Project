class AddSerialNoToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :serialNo, :string
  end
end
