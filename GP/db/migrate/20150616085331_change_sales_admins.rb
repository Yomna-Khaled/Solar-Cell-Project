class ChangeSalesAdmins < ActiveRecord::Migration
  def change
  	 add_column :sales_admins, :done, :string
  end
end
