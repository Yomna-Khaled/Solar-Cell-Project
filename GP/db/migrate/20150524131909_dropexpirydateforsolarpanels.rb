class Dropexpirydateforsolarpanels < ActiveRecord::Migration
  def change

     remove_column :solar_panels, :expire_date, :date

  end
end