class VendorMachine < ActiveRecord::Base
belongs_to :machine
belongs_to :vendor
end
