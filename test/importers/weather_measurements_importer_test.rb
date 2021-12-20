require 'test_helper'

class WeatherMeasurementsImporterTest < ActiveJob::TestCase

  setup do
    import_weathers
  end

  test 'import weather measurements' do
    assert_equal 111, WeatherMeasurement.count

    test_measurements = {
      'TAE': [1.0, 0.0, 3.6, 0.0],
      'CGI': [0.9, 0.0, 17.3, 0.0],
      'THU': [-3.7, 0.0, 5.4, 0.0]
    }

    test_measurements.each do |number, values|
      air_temp    = values[0]
      sun_time    = values[1]
      wind_speed  = values[2]
      rain_amount = values[3]

      wm = WeatherMeasurement.find_by(number: number)
      assert_equal air_temp, wm.air_temp
      assert_equal sun_time, wm.sun_time
      assert_equal wind_speed, wm.wind_speed
      assert_equal rain_amount, wm.rain_amount
    end

  end

end
