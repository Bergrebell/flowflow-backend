require 'test_helper'

class BafuImporterTest < ActiveJob::TestCase

  setup do
    hydrodata_excerpt              = File.open('test/support/hydrodata_excerpt.xml') { |f| Nokogiri::XML(f) }
    @weather_measurements_importer = BafuImporter.new(hydrodata_excerpt)
  end

  test 'imports correct data' do
    @weather_measurements_importer.call

    assert_equal 240, Station.count
    assert_equal 508, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 9.0, Station.find_by(number: '2009').temperatures.first.value
  end

end
