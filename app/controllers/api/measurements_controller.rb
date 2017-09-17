class Api::MeasurementsController < ApplicationController
  def index
    serialized_measurements = Measurement
      .most_recent
      .measured_less_than_day_ago
      .map(&:serialize)
      .group_by {|m| m[:stationId]}

    add_weather_to(serialized_measurements)

    render json: serialized_measurements
  end

  private

  def add_weather_to(serialized_measurements)
    serialized_measurements.each do |stationID, measurements|
      measurements.push(Station.find(stationID).weather_measurement.serialize)
    end
  end
end
