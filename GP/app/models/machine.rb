class Machine < ActiveRecord::Base
	validates :name, presence: true
	has_many :vendormachine
	has_many :vendors, through: :vendormachine
	validates_uniqueness_of :name
	validates :serialNo, presence: true
	validates_uniqueness_of :serialNo, on: :create
end
