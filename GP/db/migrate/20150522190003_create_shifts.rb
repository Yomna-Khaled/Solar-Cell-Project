class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.references :employee, index: true, foreign_key: true
      t.references :crew, index: true, foreign_key: true
      t.date :start_shift_date
      t.date :end_shift_date
      t.time :start_shift_time
      t.time :end_shift_time
      t.float :production_rate

      t.timestamps null: false
    end
  end
end
