class ChangeAdminsshifts < ActiveRecord::Migration
  def change
  	 add_column :admin_shifts, :done, :string
  end
end
