class RemoveblacklistedFromvendors < ActiveRecord::Migration
  def change
  	    remove_column :vendors, :blacklisted
  end
end
