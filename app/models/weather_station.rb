class WeatherStation < ApplicationRecord
  validates_presence_of :number,
                        :village,
                        :easting,
                        :northing
  validates_uniqueness_of :number

  has_one :weather_measurement
  has_one :station

  def coordinates
    [easting, northing]
  end
end
