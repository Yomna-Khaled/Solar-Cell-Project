class SparePart < ActiveRecord::Base
  belongs_to :material
  has_many :vendors, through: :vendorspare
end
