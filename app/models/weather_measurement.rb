class WeatherMeasurement < ApplicationRecord
  validates_presence_of :number

  belongs_to :weather_station
end
