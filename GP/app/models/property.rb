class Property < ActiveRecord::Base
	has_many :materials, through: :materialproperty
end
