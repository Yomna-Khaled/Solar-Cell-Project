class RemoveColumns < ActiveRecord::Migration
def self.up
  remove_column :vendors, :type
end
  def change
  end
end
