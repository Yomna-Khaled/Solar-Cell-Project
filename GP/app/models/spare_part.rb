class SparePart < ActiveRecord::Base
  has_many :vendorspare
  has_many :vendors, through: :vendorspare
  belongs_to :machine
  validates :name, :presence => true
  validates :quantity, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 } 
  has_attached_file :avatar
  validates_uniqueness_of :name
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end

