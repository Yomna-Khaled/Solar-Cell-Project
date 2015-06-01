class ChangeProductionshifts < ActiveRecord::Migration
  def change
  	add_column :production_shifts, :accepted, :string
  end
end
