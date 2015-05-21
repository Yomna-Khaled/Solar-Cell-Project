class ProductionShift < ActiveRecord::Base
  belongs_to :material
  belongs_to :crew
  belongs_to :solar_panel
end
