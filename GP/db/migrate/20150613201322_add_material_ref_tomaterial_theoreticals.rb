class AddMaterialRefTomaterialTheoreticals < ActiveRecord::Migration
  def change
  	add_reference :material_theoreticals, :material, index: true, foreign_key: true
  end
end
