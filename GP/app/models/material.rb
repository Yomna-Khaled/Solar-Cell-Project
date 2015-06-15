class Material < ActiveRecord::Base
	include Paperclip::Glue
	has_many :theoreticalcategories, through: :material_theoretical
	belongs_to :quantity
	has_many :materialproperty
	has_many :materialvendor
	has_many :properties, through: :materialproperty, dependent: :destroy
	has_many :vendors, through: :materialvendor, dependent: :destroy
	has_attached_file :avatar
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates :name, presence: true
	validates :serial_number, presence: true
	validates :quantity_value, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :Min_Number, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :stockNo, presence: true
	validates :shelfNo, presence: true
	validates :quantity_id, presence: true
	validates :avatar, presence: true
	validates_uniqueness_of :serial_number, on: :create
	validates_uniqueness_of :name, on: :create
end
