class AddTheoreticalcategoryRefTomaterialTheoreticals < ActiveRecord::Migration
  def change
  	  	add_reference :material_theoreticals, :theoreticalcategory, index: true, foreign_key: true
  end
end
