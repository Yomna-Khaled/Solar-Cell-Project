class Vendor < ActiveRecord::Base
has_many :spareparts, through: :vendorspare
has_many :containers, through: :vendorcontainer
end
