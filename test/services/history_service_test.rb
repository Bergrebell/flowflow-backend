require 'test_helper'

class HistoryServiceTest < ActiveJob::TestCase
  def setup
    @basel = stations(:basel)
  end

  test 'should return correct serialized history data' do
    expected_serialized_history = {
        "temperatures"=>[
            {:value=>21.0, :mean_7=>22.0, :datetime=>"Thu, 09 Nov 2017 23:00:00 UTC +00:00".to_time},
            {:value=>23.0, :mean_7=>22.0, :datetime=>"Wed, 08 Nov 2017 23:00:00 UTC +00:00".to_time}],
        "discharges"=>[{:value=>3.0, :mean_7=>3.0, :datetime=>"Thu, 09 Nov 2017 23:00:00 UTC +00:00".to_time}],
        "sea_levels"=>[{:value=>246.0, :mean_7=>246.0, :datetime=>"Thu, 09 Nov 2017 23:00:00 UTC +00:00".to_time}],
        "levels"=>[{:value=>100.0, :mean_7=>100.0, :datetime=>"Thu, 09 Nov 2017 23:00:00 UTC +00:00".to_time}],
        "discharge_liters"=>[{:value=>12.0, :mean_7=>12.0, :datetime=>"Thu, 09 Nov 2017 23:00:00 UTC +00:00".to_time}]
    }
    assert_equal expected_serialized_history, HistoryService.new(@basel).call
  end

end
