class AddAttachmentAvatarToSpareParts < ActiveRecord::Migration
  def self.up
    change_table :spare_parts do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :spare_parts, :avatar
  end
end
