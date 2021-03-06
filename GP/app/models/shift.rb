class Shift < ActiveRecord::Base
  belongs_to :employee
  belongs_to :crew
  validates :production_rate, :numericality => true , presence: true
  validates :crew_id,   presence: true
  has_many :solar_panels
  has_many :production_shifts
end
