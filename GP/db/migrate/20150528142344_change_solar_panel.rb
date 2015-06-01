class ChangeSolarPanel < ActiveRecord::Migration
  def change
  	 add_reference :solar_panels,:sold_panel, index: true, foreign_key: true
  end
end
