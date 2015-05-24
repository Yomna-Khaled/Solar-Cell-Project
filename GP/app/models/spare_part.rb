class SparePart < ActiveRecord::Base
  has_many :vendors, through: :vendorspare
  belongs_to :machine
  validates :name, :presence => true
  validates :quantity, :presence => true
  validates :price, :presence => true 

end
