class RemoveuserNameFromemployees < ActiveRecord::Migration
  def change
  	remove_column :employees, :user_name
  end
end
