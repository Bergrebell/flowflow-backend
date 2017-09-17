require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  def setup
    @old_measurement = measurements(:old_measurement)
    @older_than_week = measurements(:older_than_week)
    @most_recent_measurement = measurements(:most_recent_measurement)
  end

  test 'most_recent scope' do
    travel_to reference_date do
      assert_equal 8, Measurement.most_recent.count
      assert_not_includes Measurement.most_recent, @old_measurement
      assert_includes Measurement.most_recent, @most_recent_measurement
    end
  end

  test 'less_than_week_old scope' do
    travel_to reference_date do
      assert_equal 8, Measurement.less_than_week_old.count
      assert_not_includes Measurement.less_than_week_old, @older_than_week
    end
  end
end
