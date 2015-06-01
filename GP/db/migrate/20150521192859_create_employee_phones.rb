class CreateEmployeePhones < ActiveRecord::Migration
  def change
    create_table :employee_phones do |t|
      t.references :employee, index: true, foreign_key: true
      t.string :phone

      t.timestamps null: false
    end
  end
end
