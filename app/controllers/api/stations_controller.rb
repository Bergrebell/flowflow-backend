class Api::StationsController < ApplicationController

  def index
    stations = Station.all.as_json(only: [:id, :name, :water_body_name])
    render json: stations
  end

  def weather
    station = Station.find(station_params[:id])
    indicator = station.weather_station.weather_measurement.as_json
    render json: indicator
  end

  private

  def station_params
    params.permit(
      :id
    )
  end

end
