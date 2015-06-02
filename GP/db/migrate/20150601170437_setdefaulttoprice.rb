class Setdefaulttoprice < ActiveRecord::Migration
  def change
           change_column_default(:lookup_prices, :value, 0)
  end
end
