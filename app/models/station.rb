class Station < ApplicationRecord
  has_many :measurements
  has_many :discharge_liters
  has_many :discharges
  has_many :levels
  has_many :sea_levels
  has_many :temperatures

  has_one :weather_station

  validates_presence_of :number,
                        :name,
                        :water_body_name,
                        :water_body_type

  def coordinates
    [easting, northing]
  end
end
