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
        "indicator"=>"sun_cloud",
        "datetime"=>"2017-09-06T14:00:00.000+02:00"
    }
    assert_equal weather, expected_response
  end
end
