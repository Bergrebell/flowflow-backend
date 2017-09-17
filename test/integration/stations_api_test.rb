require 'test_helper'

class StationsApiTest < ActionDispatch::IntegrationTest
  test 'get api/stations' do
    get api_stations_path
    assert_response :success

    stations = JSON.parse(@response.body)
    assert_equal 2, stations.count

    expected_response = [
        {"id"=>745744336, "name"=>"Basel", "number"=>"2199", "waterBodyName"=>"Wiese", "northing"=>269700, "easting"=>611800},
        {"id"=>566109658, "name"=>"St. Gallen Bruggen/Au", "number"=>"2468", "waterBodyName"=>"Sitter", "northing"=>253230, "easting"=>742540}
    ]
    assert_equal expected_response, stations
  end
end
