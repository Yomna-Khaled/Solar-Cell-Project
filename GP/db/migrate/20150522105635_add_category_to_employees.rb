class AddCategoryToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :category, index: true, foreign_key: true
  end
end
