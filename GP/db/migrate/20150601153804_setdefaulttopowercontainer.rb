class Setdefaulttopowercontainer < ActiveRecord::Migration
  def change
      change_column_default(:containers, :total_power, 0)
  end
end
