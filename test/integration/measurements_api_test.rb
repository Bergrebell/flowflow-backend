require 'test_helper'

class MeasurementsApiTest < ActionDispatch::IntegrationTest
  def setup
    @basel = stations(:basel)
  end

  test 'get api/measurements' do
    get api_measurements_path
    assert_response :success

    measurements = JSON.parse(@response.body)
    assert_equal 1, measurements.count

    expected_response = {
        "#{@basel.id}"=>[
            {"datetime"=>"2017-09-06T15:00:00.000Z", "value"=>3.0, "measurementType"=>"Discharge", "stationId"=>@basel.id, "unit"=>"m3/s"},
            {"datetime"=>"2017-09-06T15:00:00.000Z", "value"=>246.0, "measurementType"=>"SeaLevel", "stationId"=>@basel.id, "unit"=>"m ü. M."}
        ]
    }

    assert_equal measurements, expected_response
  end
end
