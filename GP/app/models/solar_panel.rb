class SolarPanel < ActiveRecord::Base
  belongs_to :container
  belongs_to :shift
  validates  :production_date, :height, :width, :power , :celltype, :subtype, :price, :serialNo, :container_id,:cellno,   
  presence: true
  validates_uniqueness_of :serialNo
  
  def self.searchserialno(query,type)
    if type == 'ALL'
      where("serialNo like ?", "%#{query}%")
    elsif type == 'NULL'
      where("serialNo like ? AND sold_panel_id is NULL", "%#{query}%")
    else
      where("serialNo like ? AND sold_panel_id is NOT NULL", "%#{query}%")   
    end
  end
  def self.searchpower(query,type)
    # to handle case if the user enter value float (ex: 200.00) 
    # this value inserted at the data base as (200) only 
    # so to compare we must remove the values after the point 
    aftermark=query.split('.')[1].to_i
    if aftermark > 0
      query = query
    else
      query = query.split('.')[0]
    end
     if type == 'ALL'
      where("power like ?", "%#{query}%")
    elsif type == 'NULL'
      where("power like ? AND sold_panel_id is NULL", "%#{query}%")
    else
      where("power like ? AND sold_panel_id is NOT NULL", "%#{query}%")   
    end
  end
end
