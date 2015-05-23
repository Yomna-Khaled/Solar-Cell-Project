require 'digest/md5'
class Employee < ActiveRecord::Base
  belongs_to :crew
  belongs_to :category

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/ 

  validates_presence_of :password, :if => :not_normal? , :length => {:within => 6..40}, :on => :create
  validates_presence_of :user_name, :if => :not_normal?

  validates :first_name, :last_name, :salary, :image , :education_level, :Governamental_ID, :position, :crew_id, :category_id, presence: true
  validates :salary, :numericality => { :greater_than_or_equal_to => 0 }

  validates_uniqueness_of :user_name

  def not_normal?
    @category = Category.find_by(id: category_id)
    @category.category != "Normal"
  end
end
