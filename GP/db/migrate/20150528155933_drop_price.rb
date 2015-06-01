class DropPrice < ActiveRecord::Migration
  def change
   drop_table :prices
  end
end
