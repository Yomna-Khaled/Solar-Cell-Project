class CreateEmployeeManagers < ActiveRecord::Migration
  def change
    create_table :employee_managers do |t|
      t.references :employee, index: true, foreign_key: true
      t.references :crew, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
