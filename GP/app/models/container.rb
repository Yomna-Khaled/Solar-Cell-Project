class Container < ActiveRecord::Base

 has_many :solar_panels
 has_many :vendors, through: :vendorcontainer

 validates :width, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
 validates :height, :presence => true, :numericality => { :greater_than_or_equal_to => 0 } 
 validates :capacity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
 validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 } 
 
 validates :serialNo, presence: true
 validates_uniqueness_of :serialNo, on: :create

end
