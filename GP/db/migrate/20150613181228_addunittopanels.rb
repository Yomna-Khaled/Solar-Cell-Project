class Addunittopanels < ActiveRecord::Migration
  def change
     add_column :solar_panels, :dimensionunit, :string
  end
end
