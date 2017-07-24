class Station < ApplicationRecord
  has_many :measurements
  has_many :discharge_liters
  has_many :discharges
  has_many :levels
  has_many :sea_levels
  has_many :temperatures
end
