require 'test_helper'

class StationsApiTest < ActionDispatch::IntegrationTest
  test 'get api/stations' do
    get api_stations_path
    assert_response :success

    stations = JSON.parse(@response.body)
    assert_equal 2, stations.count

    expected_response = [
        {"id"=>566109658, "name"=>"St. Gallen Bruggen/Au", "waterBodyName"=>"Sitter"},
        {"id"=>745744336, "name"=>"Basel", "waterBodyName"=>"Wiese"}
    ]
    assert_equal expected_response, stations
  end
end
