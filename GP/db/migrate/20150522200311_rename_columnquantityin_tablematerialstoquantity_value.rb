class RenameColumnquantityinTablematerialstoquantityValue < ActiveRecord::Migration
  def change
  	rename_column :materials, :quantity, :quantity_value
  end
end
