class Station < ApplicationRecord
  has_many :measurements
  has_many :discharge_liters
  has_many :discharges
  has_many :levels
  has_many :sea_levels
  has_many :temperatures

  belongs_to :weather_station

  validates_presence_of :number,
                        :name,
                        :water_body_name,
                        :water_body_type

  scope :lakes, -> { where(water_body_type: 'lake') }

  def serialize
    {
      id: id,
      name: name,
      waterBodyName: water_body_name
    }
  end

  def coordinates
    [easting, northing]
  end
end
