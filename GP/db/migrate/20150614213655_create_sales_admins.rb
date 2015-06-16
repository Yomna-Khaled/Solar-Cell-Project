class CreateSalesAdmins < ActiveRecord::Migration
  def change
    create_table :sales_admins do |t|
      t.float :power
      t.string :type
      t.string :subtype

      t.timestamps null: false
    end
  end
end
