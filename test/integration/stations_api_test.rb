require 'test_helper'

class StationsApiTest < ActionDispatch::IntegrationTest
  test 'get api/stations' do
    get api_stations_path
    assert_response :success

    stations = JSON.parse(@response.body)
    assert_equal 3, stations.count

    expected_response = [
        { 'id' => 745744336, 'name' => 'Basel', "water_body_name" => 'Wiese' },
        { 'id' => 81157957, 'name' => 'Locarno', "water_body_name" => 'Lago Maggiore' },
        { 'id' => 566109658, 'name' => 'St. Gallen Bruggen/Au', "water_body_name" => 'Sitter' }
    ]
    assert_equal stations, expected_response
  end
end
