class WeatherMeasurementSerializer < ActiveModel::Serializer
  attribute :station
  attribute :air_temp, key: :airTemperature
  attribute :sun_time, key: :sunTime
  attribute :wind_speed, key: :windSpeed
  attribute :rain_amount, key: :rainAmount
  attribute :measured_at, key: :measuredAt

  def measured_at
    object.datetime
  end

  def station
    object.weather_station.station.serialize
  end
end
