class AddTheoreticalcategoryRefTosolarPanels < ActiveRecord::Migration
  def change
  	    add_reference :solar_panels, :theoreticalcategory, index: true, foreign_key: true

  end
end
