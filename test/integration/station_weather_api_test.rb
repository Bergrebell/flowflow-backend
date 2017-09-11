require 'test_helper'

class StationWeatherApiTest < ActionDispatch::IntegrationTest

  def setup
    @basel = stations(:basel)
  end

  test "get /station/:id/weather" do
    get api_station_weather_path(@basel)
    assert_response :success

    weather = JSON.parse(@response.body)
    assert_equal 4, weather.count

    expected_response = {
        "air_temp"=>16.0,
        "wind_speed"=>15.8,
        "indicator"=>"cloud",
        "datetime"=>"2017-09-06T12:00:00.000Z"
    }
    assert_equal expected_response, weather
  end
end
