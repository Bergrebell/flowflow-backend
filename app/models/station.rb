class Station < ApplicationRecord
  has_many :measurements
  has_many :discharge_liters
  has_many :discharges
  has_many :levels
  has_many :sea_levels
  has_many :temperatures

  belongs_to :weather_station
  has_one :weather_measurement, through: :weather_station

  validates_presence_of :number,
                        :name,
                        :water_body_name,
                        :water_body_type

  scope :lakes, -> { where(water_body_type: 'lake') }

  def has_measurements_younger_than_a_day?
    measurements.most_recent
                .map { |m| m.measured_less_than_day_ago? }
                .any?
  end

  def serialize
    {
      id: id,
      name: name,
      number: number,
      waterBodyName: water_body_name,
      northing: northing,
      easting: easting
    }
  end

  def coordinates
    [easting, northing]
  end
end
