class VendorContainer < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :container
end
