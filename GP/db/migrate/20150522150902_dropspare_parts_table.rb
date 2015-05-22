class DropsparePartsTable < ActiveRecord::Migration
  def up
    drop_table :spare_parts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
