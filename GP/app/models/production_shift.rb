class ProductionShift < ActiveRecord::Base
  belongs_to :material
  belongs_to :shift
end
