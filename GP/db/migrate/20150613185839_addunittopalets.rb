class Addunittopalets < ActiveRecord::Migration
  def change
      add_column :containers, :containerdimensionunit, :string
  end
end
