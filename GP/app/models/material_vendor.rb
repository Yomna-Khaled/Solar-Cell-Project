class MaterialVendor < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :material
end
