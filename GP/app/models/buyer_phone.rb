class BuyerPhone < ActiveRecord::Base
  belongs_to :buyer
   validates_uniqueness_of :phone
end
