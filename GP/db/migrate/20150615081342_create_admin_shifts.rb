class CreateAdminShifts < ActiveRecord::Migration
  def change
    create_table :admin_shifts do |t|
      t.float :power
      t.string :type
      t.string :subtype
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
