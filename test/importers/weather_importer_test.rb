require 'test_helper'

class WeatherImporterTest < ActiveJob::TestCase

  setup do
    weatherdata_excerpt = 'test/support/weatherdata_excerpt.csv'
    @importer = WeatherImporter.new(weatherdata_excerpt)
  end

  test 'perform' do
    @importer.call

    assert_equal 240, Station.count
    assert_equal 508, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 9.0, Station.find_by(number: '2009').temperatures.first.value
  end

end
