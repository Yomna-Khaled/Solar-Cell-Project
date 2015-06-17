class Theoreticalcategory < ActiveRecord::Base
	has_many :solar_panels
        has_many :material_theoreticals
	has_many :materials, through: :material_theoretical
	validates_uniqueness_of :name, on: :create
	validates :name, presence: true	
        accepts_nested_attributes_for :material_theoreticals
end
