class Container < ActiveRecord::Base
 has_many :vendors, through: :vendorcontainer
end
