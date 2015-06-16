class CreateMaterialTheoreticals < ActiveRecord::Migration
  def change
    create_table :material_theoreticals do |t|
      t.string :value

      t.timestamps null: false
    end
  end
end
