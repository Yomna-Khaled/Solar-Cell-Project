class AddVentypeToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :ventype, :string
  end
end
