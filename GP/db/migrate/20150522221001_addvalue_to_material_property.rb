class AddvalueToMaterialProperty < ActiveRecord::Migration
  def change
  	add_column :material_properties, :value, :string
  end
end
