class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.string :no_of_workers

      t.timestamps null: false
    end
  end
end
