class EducationToemployees < ActiveRecord::Migration
  def change
  	    add_column :employees, :education, :text
  end
end
