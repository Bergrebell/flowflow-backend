# frozen_string_literal: true

class WeatherStationSerializer < ActiveModel::Serializer
  attribute :village
  attributes :latitude, :longitude

  def latitude
    gps_coordinates[0]
  end

  def longitude
    gps_coordinates[1]
  end

  private

  def gps_coordinates
    Swissgrid::WGS84(object.coordinates)
  end
end
