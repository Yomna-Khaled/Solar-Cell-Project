class Buyer < ActiveRecord::Base
has_many :buyerphones 
validates :name, :presence => true
validates :addess, :presence => true
validates :city, :presence => true
end
