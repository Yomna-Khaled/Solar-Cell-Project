class Crew < ActiveRecord::Base
	validates :no_of_workers, :numericality => { :greater_than_or_equal_to => 1 }, presence: true
end
