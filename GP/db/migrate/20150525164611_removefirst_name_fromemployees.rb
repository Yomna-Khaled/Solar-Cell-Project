class RemovefirstNameFromemployees < ActiveRecord::Migration
  def change
  	remove_column :employees, :first_name
  end
end
