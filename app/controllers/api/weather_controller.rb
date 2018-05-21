class Api::WeatherController < ApplicationController

  def at_location
    @gps_coordinates = [params[:latitude], params[:longitude]].map(&:to_f)
    return render status: 422 unless gps_coordinates_valid?

    ch1903_coordinates = Swissgrid::CH1903(@gps_coordinates)
    weather_station = ConnectWaterToWeatherStationsService.new(ch1903_coordinates).nearest_weather_station

    render json: weather_station.weather_measurement
  end

  private

  def gps_coordinates_valid?
    @gps_coordinates.select(&:present?).count == 2
  end
end
