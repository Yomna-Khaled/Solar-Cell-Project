class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.string :unit_name

      t.timestamps null: false
    end
  end
end
