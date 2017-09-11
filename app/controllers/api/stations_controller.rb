class Api::StationsController < ApplicationController
  before_action :set_station, only: [:weather, :history]

  def index
    stations = Station.all.as_json(only: [:id, :name, :water_body_name])
    render json: stations
  end

  def weather
    weather_measurement = @station.weather_station.weather_measurement.as_json
    render json: weather_measurement
  end


  def history
    history = HistoryService.new(@station).call
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
