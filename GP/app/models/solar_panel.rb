class SolarPanel < ActiveRecord::Base
  belongs_to :container
  belongs_to :shift
  validates  :production_date, :height, :width, :power , :celltype, :subtype, :price, :serialNo, :container_id,:cellno,   
  presence: true
  validates_uniqueness_of :serialNo
  
  def self.searchserialno(query)
  	where("serialNo like ?", "%#{query}%") 
  end
  def self.searchpower(query)
  	where("power like ?", "%#{query}%")
  end
end
