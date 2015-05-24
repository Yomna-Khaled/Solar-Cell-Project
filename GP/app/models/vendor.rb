class Vendor < ActiveRecord::Base
	has_many :containers,:through => :vendor_containers
end
