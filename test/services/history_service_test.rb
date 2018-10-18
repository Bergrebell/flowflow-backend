# frozen_string_literal: true

require 'test_helper'

class HistoryServiceTest < ActiveJob::TestCase
  def setup
    @basel = stations(:basel)
  end

  test 'should return correct serialized history data' do
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
end
