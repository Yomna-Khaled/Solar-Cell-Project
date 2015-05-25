class Renametypeinsolarpanel < ActiveRecord::Migration
  def change
  	rename_column :solar_panels,:type,:celltype
  end
end
