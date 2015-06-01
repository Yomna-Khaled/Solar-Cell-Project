class AddNoCellOnSolarpanel < ActiveRecord::Migration
  def change
     add_column :solar_panels, :cellno, :integer
  end
end
