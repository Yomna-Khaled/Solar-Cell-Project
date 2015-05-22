class DropproductionShiftsTable < ActiveRecord::Migration
  def up
    drop_table :production_shifts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end