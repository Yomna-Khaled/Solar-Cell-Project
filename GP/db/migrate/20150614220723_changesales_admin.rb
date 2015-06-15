class ChangesalesAdmin < ActiveRecord::Migration
  def change
  	 rename_column :sales_admins, :type, :celltype
  end
end
