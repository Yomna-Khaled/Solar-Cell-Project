class EmployeePhone < ActiveRecord::Base
  belongs_to :employee
   validates_uniqueness_of :phone
end
