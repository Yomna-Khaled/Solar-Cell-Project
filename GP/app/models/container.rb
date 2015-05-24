class Container < ActiveRecord::Base

 has_many :vendors, through: :vendorcontainer
 validates :width, :presence => true 
 validates :height, :presence => true 
 validates :capacity, :presence => true
 validates :price, :presence => true 
 validates :total_power, :presence => true

end
