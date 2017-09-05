require 'test_helper'

class ConnectWeatherToWaterStationsServiceTest < ActiveJob::TestCase

  def setup
    @basel = WeatherStation.find_by(number: 'BAS')
    @locarno = WeatherStation.find_by(number: 'OTL')
    @st_gallen = WeatherStation.find_by(number: 'STG')
  end

  test 'return nearest station for weather_station-location' do
    assert_equal stations(:basel), ConnectWeatherToWaterStationsService.new(@basel.coordinates).nearest_station
    assert_equal stations(:locarno), ConnectWeatherToWaterStationsService.new(@locarno.coordinates).nearest_station
    assert_equal stations(:st_gallen), ConnectWeatherToWaterStationsService.new(@st_gallen.coordinates).nearest_station
  end

end
