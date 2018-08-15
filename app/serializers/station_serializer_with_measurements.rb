# frozen_string_literal: true

class StationSerializerWithMeasurements < StationSerializer
  attributes :id,
             :name,
             :latitude,
             :longitude,
             :village
  attribute  :water_body_name, key: :waterBodyName
  attribute  :water_body_type, key: :waterBodyType
  attributes :water,
             :weather

  def village
    object.weather_station.village
  end

  def water
    [[:temperature, temperature], [:discharge, discharge], [:level, level]]
      .select { |_key, measurement| measurement.present? }
      .to_h
  end

  def weather
    ActiveModelSerializers::SerializableResource.new(object.weather_station.weather_measurement)
  end
end
