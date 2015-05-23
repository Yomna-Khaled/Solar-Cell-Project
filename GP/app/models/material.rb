class Material < ActiveRecord::Base
	include Paperclip::Glue
	belongs_to :quantity
	has_many :properties, through: :materialproperty
	has_many :vendors, through: :materialvendor
	has_attached_file :avatar
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
