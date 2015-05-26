class Shift < ActiveRecord::Base
  belongs_to :employee
  belongs_to :crew
  validates :production_rate, :numericality => true , presence: true
  has_many :solarpanels
  has_many :production_shifts
end
