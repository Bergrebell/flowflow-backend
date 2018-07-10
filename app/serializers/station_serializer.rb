# frozen_string_literal: true

class StationSerializer < ActiveModel::Serializer
  attribute :name
  attribute :water_body_name, key: :waterBodyName
  attribute :water_body_type, key: :waterBodyType
  attributes :latitude, :longitude

  def temperature
    serialize :temperatures
  end

  def discharge
    serialize :discharges, :discharge_liters
  end

  def level
    serialize :levels, :sea_levels
  end

  def latitude
    gps_coordinates[0]
  end

  def longitude
    gps_coordinates[1]
  end

  private

  def serialize(*measurement_keys)
    data = measurements(measurement_keys).group_by(&:unit)
    data_points = data.values.first&.sort_by(&:datetime)

    raise 'Multiple units found in data set.' if data.keys.count > 1

    {
      unit: data.keys.first,
      values: ActiveModelSerializers::SerializableResource.new(data_points)
    }
  end

  def measurements(measurement_keys)
    measurement_keys
      .map { |measurement_key| object.send(measurement_key).less_than_week_old }
      .flatten
      .uniq { |measurement| [measurement.datetime, measurement.unit] }
  end

  def gps_coordinates
    Swissgrid::WGS84(object.coordinates)
  end
end
