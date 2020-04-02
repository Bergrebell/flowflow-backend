require 'test_helper'

class WeatherMeasurementsImporterTest < ActiveJob::TestCase

  setup do
    import_weathers
  end

  test 'import weather measurements' do
    assert_equal 111, WeatherMeasurement.count

    test_measurements = {
      'TAE': [13.0, 10.0, 9.4, 0.0],
      'CGI': [12.9, 10.0, 13.0, 0.0],
      'THU': [13.2, 10.0, 9.4, 0.0]
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
