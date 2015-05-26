class Property < ActiveRecord::Base
	has_many :materialproperty
	has_many :materials, through: :materialproperty, dependent: :destroy
end
