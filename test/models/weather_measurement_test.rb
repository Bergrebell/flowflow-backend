require 'test_helper'

class WeatherMeasurementTest < ActiveSupport::TestCase
  def setup
    @bsl = weather_measurements(:bsl)
  end

  test 'valid indicators' do
    expected_json = {
        :airTemp   => 16.0,
        :windSpeed => 15.8,
        :indicator  => 'cloud',
        :datetime   => 'Wed, 06 Sep 2017 12:00:00 UTC +00:00'.to_time
    }

    assert_equal expected_json, @bsl.serialize
  end

end
