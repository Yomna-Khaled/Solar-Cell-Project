class SparePart < ActiveRecord::Base
  has_many :vendorspare
  has_many :vendors, through: :vendorspare
  belongs_to :machine
  validates :name, :presence => true
  validates :quantity, :presence => true
  validates :price, :presence => true 
  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
