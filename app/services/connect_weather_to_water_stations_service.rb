require 'knnball'

class ConnectWeatherToWaterStationsService

  def initialize(weather_station_location)
    @weather_station_location = weather_station_location
  end

  def nearest_station
    index = KnnBall.build(station_data)
    station_id_and_position = index.nearest(@weather_station_location)
    Station.find(station_id_and_position[:id])
  end

  private

  # target-format:
  # data = [
  #   {:id => 1, :point => [6.3299934, 52.32444]},
  #   {:id => 2, :point => [3.34444, 53.23259]},
  #   {:id => 3, :point => [4.22452, 53.243982]},
  #   {:id => 4, :point => [4.2333424, 51.239994]},
  #   # ...
  # ]
  def station_data
    Station.all.map do |s|
      { id: s.id, point: [s.easting, s.northing] }
    end
  end

end
