class GivePriceDefaultValueSolarpanel < ActiveRecord::Migration
  def change
      change_column_default(:solar_panels, :price, 0)
  end
end
