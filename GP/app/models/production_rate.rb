class ProductionRate < ActiveRecord::Base
	validates :number_of_panels_per_hour, presence: true
end
