class ChangeNames < ActiveRecord::Migration
  def change
    rename_column :employees, :type, :user_type
  end
end
