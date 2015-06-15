class ChangeVendor < ActiveRecord::Migration
  def change
  	add_column :vendors, :blacklisted, :string
  end
end
