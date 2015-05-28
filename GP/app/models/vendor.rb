class Vendor < ActiveRecord::Base

has_many :spareparts, through: :vendorspare
has_many :containers, through: :vendorcontainer
has_many :vendorphones 
validates :name, :presence => true
validates :email, :presence => true
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
has_many :materialvendor
has_many :materials, through: :materialvendor

end
