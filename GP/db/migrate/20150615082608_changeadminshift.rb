class Changeadminshift < ActiveRecord::Migration
  def change
  	rename_column :admin_shifts, :type, :celltype
  end
end
