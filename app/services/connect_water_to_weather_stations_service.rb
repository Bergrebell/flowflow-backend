require 'knnball'

class ConnectWaterToWeatherStationsService

  def initialize(station_location)
    @station_location = station_location
  end

  def nearest_weather_station
    index = KnnBall.build(weather_station_data)
    weather_station_id_and_position = index.nearest(@station_location)
    WeatherStation.find(weather_station_id_and_position[:id])
  end

  private

  # target-format:
  # data = [
  #   {:id => 1, :point => [6.3299934, 52.32444]},
  #   {:id => 2, :point => [3.34444, 53.23259]}
  # ]
  def weather_station_data
    WeatherStation.all.map do |ws|
      { id: ws.id, point: ws.coordinates }
    end
  end

end
