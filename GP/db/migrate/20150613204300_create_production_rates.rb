class CreateProductionRates < ActiveRecord::Migration
  def change
    create_table :production_rates do |t|
      t.string :number_of_panels_per_hour

      t.timestamps null: false
    end
  end
end
