require 'digest/md5'
class Employee < ActiveRecord::Base
  belongs_to :crew
  belongs_to :category

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/ 
  validates_presence_of  :password, :if => :not_normal? , :length => {:within => 6..10}
  validates_presence_of :email, :if => :not_normal? , :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates  :image , :education_level, :education, :Governamental_ID, :category_id, presence: true
  validates :salary, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validates :Governamental_ID, :numericality => { :greater_than_or_equal_to => 0 }, :length => { :within => 12..12 }
  validates_uniqueness_of :full_name, :Governamental_ID , on: :create

  def not_normal?
    @category = Category.find_by(id: category_id)
    @category.category != "Normal"
  end
end
