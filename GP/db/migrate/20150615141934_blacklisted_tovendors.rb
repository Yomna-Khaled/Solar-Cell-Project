class BlacklistedTovendors < ActiveRecord::Migration
  def change
  	    add_column :vendors, :blacklisted, :string , :default => "no"
  end
end
