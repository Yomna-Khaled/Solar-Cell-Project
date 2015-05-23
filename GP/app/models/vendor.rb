class Vendor < ActiveRecord::Base
	  has_many :materials, through: :materialvendor
end
