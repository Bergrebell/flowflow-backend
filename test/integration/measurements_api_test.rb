require 'test_helper'

class MeasurementsApiTest < ActionDispatch::IntegrationTest
  def setup
    @basel = stations(:basel)
  end

  test 'get api/measurements' do
    get api_measurements_path
    assert_response :success

    basel_measurements = JSON.parse(@response.body)[@basel.id.to_s]
    assert_equal 5, basel_measurements.count

    expected_response = [
      {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>3.0, "measurementType"=>"Discharge", "stationId"=>745744336, "unit"=>"m3/s"},
      {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>246.0, "measurementType"=>"SeaLevel", "stationId"=>745744336, "unit"=>"m ü. M."},
      {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>21.0, "measurementType"=>"Temperature", "stationId"=>745744336, "unit"=>"°C"},
      {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>100.0, "measurementType"=>"Level", "stationId"=>745744336, "unit"=>"m"},
      {"datetime"=>"2017-11-09T23:00:00.000Z", "value"=>12.0, "measurementType"=>"DischargeLiter", "stationId"=>745744336, "unit"=>"l/s"}
    ]
    assert_equal expected_response, basel_measurements
  end
end
