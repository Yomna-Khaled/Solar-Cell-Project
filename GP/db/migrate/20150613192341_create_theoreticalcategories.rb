class CreateTheoreticalcategories < ActiveRecord::Migration
  def change
    create_table :theoreticalcategories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
