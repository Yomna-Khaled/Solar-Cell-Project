class RemoveuserTypeFromemployees < ActiveRecord::Migration
  def change
  	remove_column :employees, :user_type
  end
end
