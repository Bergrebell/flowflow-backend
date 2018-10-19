# frozen_string_literal: true

require 'test_helper'

class HistoryServiceTest < ActiveJob::TestCase
  def setup
    weather_station = WeatherStation.create!(number: 0, village: 'Test village', easting: 0, northing: 0)
    @station = Station.create!(name: 'History Test Station', weather_station: weather_station, water_body_name: 'Test water', water_body_type: 'test', number: 0)

    (59.days.ago.to_date..Date.today).each_with_index do |day, index|
      Measurement.create!(
        type: 'Temperature',
        datetime: day + 1.days,
        value: index,
        unit: 'celsius',
        station: @station
      )
    end
  end

  test 'should return correct serialized history data' do
    @basel = stations(:basel)

    travel_to reference_date do
      expected_serialized_history = {
        'temperatures' => [{ value: 21.0, weeklyAverage: 22.0, datetime: 'Thu, 09 Nov 2017 23:00:00 UTC +00:00'.to_time },
                           { value: 23.0, weeklyAverage: 22.0, datetime: 'Wed, 08 Nov 2017 23:00:00 UTC +00:00'.to_time }],
        'discharges' => [{ value: 3.0, weeklyAverage: 3.0, datetime: 'Thu, 09 Nov 2017 23:00:00 UTC +00:00'.to_time }],
        'sealevels' => [{ value: 246.0, weeklyAverage: 246.0, datetime: 'Thu, 09 Nov 2017 23:00:00 UTC +00:00'.to_time }],
        'levels' => [{ value: 100.0, weeklyAverage: 100.0, datetime: 'Thu, 09 Nov 2017 23:00:00 UTC +00:00'.to_time }],
        'dischargeliters' => [{ value: 12.0, weeklyAverage: 12.0, datetime: 'Thu, 09 Nov 2017 23:00:00 UTC +00:00'.to_time }]
      }

      assert_equal expected_serialized_history, HistoryService.new(@basel).call
    end
  end

  test 'should return correct measurement values' do
    expected_serialized_history = {
      'temperatures' => {
        values: [
          1.0, 4.0, 7.0, 10.0, 13.0, 16.0, 19.0, 22.0, 25.0, 28.0, 31.0, 34.0, 37.0, 40.0, 43.0, 46.0, 49.0, 52.0, 55.0, 58.0
        ],
        average: 29.5
      }
    }

    assert_equal expected_serialized_history, HistoryService.new(@station).history
  end
end
