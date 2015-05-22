class DropvendorSparesTable < ActiveRecord::Migration
  def up
    drop_table :vendor_spares
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
