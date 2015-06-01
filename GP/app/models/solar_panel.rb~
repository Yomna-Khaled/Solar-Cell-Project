class SolarPanel < ActiveRecord::Base
  belongs_to :container
  belongs_to :shift
  validates  :production_date, :height, :width, :power , :celltype, :subtype, :price, :serialNo, :container_id,   
  presence: true
  validates_uniqueness_of :serialNo
end
