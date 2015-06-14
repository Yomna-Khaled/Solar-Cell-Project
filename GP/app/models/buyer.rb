class Buyer < ActiveRecord::Base
has_many :buyerphones 
validates :name, :presence => true
validates_uniqueness_of :name, on: :create
validates :addess, :presence => true
validates :city, :presence => true
validates :email, :presence => true
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
