class VendorPhone < ActiveRecord::Base
  belongs_to :vendor
  validates_uniqueness_of :phone
end


