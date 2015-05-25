class NameTocrews < ActiveRecord::Migration
  def change
  	    add_column :crews, :name, :string
  end
end
