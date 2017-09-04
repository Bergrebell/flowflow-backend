class WeatherStation < ApplicationRecord
  validates_presence_of :number,
                        :village,
                        :easting,
                        :northing
end
