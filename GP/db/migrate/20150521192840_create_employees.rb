class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.float :salary
      t.float :houre_rate
      t.text :education_level
      t.string :Governamental_ID
      t.string :position
      t.string :type
      t.references :crew, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
