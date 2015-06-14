class AddvendorToMachines < ActiveRecord::Migration
  def change
     add_reference :machines, :vendor
     add_foreign_key :machines, :vendors
  end
end
