class MaterialProperty < ActiveRecord::Base
  belongs_to :material
  belongs_to :property
end
