class Buyer < ActiveRecord::Base
has_many :buyerphones 
validates :name, :presence => true
validates_uniqueness_of :name, on: :create
validates :addess, :presence => true
validates :city, :presence => true
end
