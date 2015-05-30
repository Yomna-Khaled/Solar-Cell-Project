class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :addess
      t.string :city

      t.timestamps null: false
    end
  end
end
