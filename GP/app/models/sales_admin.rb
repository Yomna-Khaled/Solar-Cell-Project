class SalesAdmin < ActiveRecord::Base
	 validates :power, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end
