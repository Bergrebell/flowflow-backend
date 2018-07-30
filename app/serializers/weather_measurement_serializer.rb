# frozen_string_literal: true

class WeatherMeasurementSerializer < ActiveModel::Serializer
  attribute :measured_at, key: :measuredAt
  attribute :air_temp, key: :temperature
  attribute :sun_time, key: :sunshine
  attribute :wind_speed, key: :windSpeed
  attribute :rain_amount, key: :precipitation
  attribute :weather_icon, key: :indicator

  def measured_at
    object.datetime
  end

  def air_temp
    { unit: '°C', description: 'Air temperature 2m above ground at the referenced timestamp', value: object.air_temp }
  end

  def sun_time
    { unit: 'min', description: 'Duration of sunshine within the last 10min', value: object.sun_time }
  end

  def wind_speed
    { unit: 'km/h', description: 'Average of the wind speed in the last 10min', value: object.wind_speed }
  end

  def rain_amount
    { unit: 'mm', description: 'Precipitation within the last 10min', value: object.rain_amount }
  end

  def weather_icon
    {description: 'Weather indicator [sun, sun_cloud, cloud, rain]', value: object.indicator}
  end
end
