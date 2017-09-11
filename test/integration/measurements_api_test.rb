require 'test_helper'

class MeasurementsApiTest < ActionDispatch::IntegrationTest
  def setup
    @basel = stations(:basel)
  end

  test 'get api/measurements' do
    get api_measurements_path
    assert_response :success

    basel_measurements = JSON.parse(@response.body)[@basel.id.to_s]
    assert_equal 2, basel_measurements.count

    expected_response = [
        {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>3.0, "measurementType"=>"Discharge", "stationId"=>@basel.id, "unit"=>"m3/s"},
        {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>246.0, "measurementType"=>"SeaLevel", "stationId"=>@basel.id, "unit"=>"m ü. M."}
    ]

    assert_equal basel_measurements, expected_response
  end
end
