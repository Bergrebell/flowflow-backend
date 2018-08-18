# frozen_string_literal: true

module Api
  class StationsController < ApplicationController
    before_action :set_station, only: %i[weather history]

    def index
      # Client.joins(:orders).where('orders.created_at' => time_range)
      stations = Station.all
                        .joins(:measurements)
                        .where('measurements.datetime >= ?', 1.day.ago)
                        .distinct
                        .map(&:serialize)

      render json: stations
    end

    def show
      @station = Station.find(params[:id])

      render json: StationSerializerWithMeasurements.new(@station).as_json
    end

    def weather
      weather_measurement = @station.weather_station.weather_measurement.serialize
      render json: weather_measurement
    end

    def history
      history = HistoryService.new(@station).history
      render json: history
    end

    private

    def set_station
      @station = Station.find(station_params[:id])
    end

    def station_params
      params.permit(
        :id
      )
    end
  end
end
