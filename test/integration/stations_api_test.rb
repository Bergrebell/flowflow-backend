# frozen_string_literal: true

require 'test_helper'

class StationsApiTest < ActionDispatch::IntegrationTest
  test 'get api/stations' do
    travel_to reference_date - 1.day do
      get api_stations_path
      assert_response :success

      stations = JSON.parse(@response.body)
      assert_equal 2, stations.count

      expected_response = [
        { 'id' => 745_744_336, 'name' => 'Basel', 'waterBodyName' => 'Wiese', 'waterBodyType' => 'river' },
        { 'id' => 566_109_658, 'name' => 'St. Gallen Bruggen/Au', 'waterBodyName' => 'Sitter', 'waterBodyType' => 'river' }
      ]

      assert_equal expected_response, stations
    end
  end
end
