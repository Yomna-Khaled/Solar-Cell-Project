class RemoveColumnss < ActiveRecord::Migration
def self.up
  remove_column :machines, :vendor_id
end
  def change
  end
end
