require 'test_helper'

class ConnectWaterToWeatherStationsServiceTest < ActiveJob::TestCase

  def setup
    @basel = stations(:basel)
    @locarno = stations(:locarno)
    @st_gallen = stations(:st_gallen)

    @weather_basel = weather_stations(:weather_basel)
    @weather_locarno = weather_stations(:weather_locarno)
    @weather_st_gallen = weather_stations(:weather_st_gallen)
  end

  test 'return nearest station for weather_station-location' do
    assert_equal ConnectWaterToWeatherStationsService.new(@basel.coordinates).nearest_weather_station, @weather_basel
    assert_equal ConnectWaterToWeatherStationsService.new(@locarno.coordinates).nearest_weather_station, @weather_locarno
    assert_equal ConnectWaterToWeatherStationsService.new(@st_gallen.coordinates).nearest_weather_station, @weather_st_gallen
  end

end
