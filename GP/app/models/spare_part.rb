class SparePart < ActiveRecord::Base

  has_many :vendors, through: :vendorspare

  belongs_to :machine

end
