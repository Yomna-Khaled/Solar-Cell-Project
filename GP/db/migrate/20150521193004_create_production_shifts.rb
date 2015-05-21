class CreateProductionShifts < ActiveRecord::Migration
  def change
    create_table :production_shifts do |t|
      t.references :material, index: true, foreign_key: true
      t.references :crew, index: true, foreign_key: true
      t.references :solar_panel, index: true, foreign_key: true
      t.date :start_shift
      t.date :end_shift

      t.timestamps null: false
    end
  end
end
