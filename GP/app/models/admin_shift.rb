class AdminShift < ActiveRecord::Base
  belongs_to :employee
   validates :power, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

end
