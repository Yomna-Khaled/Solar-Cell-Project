class AddSerialNumberTomaterials < ActiveRecord::Migration
  def change
  	add_column :materials, :serial_number, :string
  end
end
