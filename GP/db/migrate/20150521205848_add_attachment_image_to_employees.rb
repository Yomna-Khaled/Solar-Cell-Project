class AddAttachmentImageToEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :employees, :image
  end
end
