class AddDefaultProductionRate < ActiveRecord::Migration
  def change
      change_column_default(:shifts, :production_rate, 0)
  end
end
