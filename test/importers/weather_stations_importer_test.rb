require 'test_helper'

class WeatherStationsImporterTest < ActiveJob::TestCase

  setup do
    import_weather_stations
  end

  test 'weather station import data' do
    assert_equal 111, WeatherStation.count

    eastings = {
        BER: 601929,
        SHA: 688698,
        ELM: 732265,
        THU: 611202
    }

    northings = {
        BER: 204409,
        SHA: 282796,
        ELM: 198425,
        THU: 177630
    }

    villages = {
        BER: 'Bern/Zollikofen',
        SHA: 'Schaffhausen',
        ELM: 'Elm',
        THU: 'Thun'
    }

    eastings.each do |number, value|
      ws = WeatherStation.find_by(number: number)
      assert_equal value, ws.easting
    end

    northings.each do |number, value|
      ws = WeatherStation.find_by(number: number)
      assert_equal value, ws.northing
    end

    villages.each do |number, value|
      ws = WeatherStation.find_by(number: number)
      assert_equal value, ws.village
    end
  end
end
