require 'test_helper'

class WeatherMeasurementTest < ActiveSupport::TestCase
  def setup
    @stg = weather_measurements(:stg)
  end

  test 'valid indicators' do
    expected_json = {
      :air_temp=>16.0,
      :wind_speed=>15.8,
      :indicator=>"sun_cloud" }

    assert_equal @stg.as_json, expected_json
  end

end
