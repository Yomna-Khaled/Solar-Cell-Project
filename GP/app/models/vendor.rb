class Vendor < ActiveRecord::Base
	has_many :materialvendor
	has_many :materials, through: :materialvendor, dependent: :destroy
end
