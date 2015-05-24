class Shift < ActiveRecord::Base
  belongs_to :employee
  belongs_to :crew
  has_many :production_shifts
end
