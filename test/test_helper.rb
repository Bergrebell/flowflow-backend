ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def import_all
    import_weathers
    import_waters
  end

  def import_waters
    hydrodata_excerpt = File.open('test/support/hydrodata_excerpt.xml') { |f| Nokogiri::XML(f) }
    weather_measurements_importer = BafuImporter.new(hydrodata_excerpt)
    weather_measurements_importer.call
  end

  def import_weathers
    import_weather_stations
    import_weather_measurements
  end

  def import_weather_stations
    weather_measurements_importer = WeatherStationsImporter.new('lib/support/weather_stations.csv')
    weather_measurements_importer.call
  end

  def import_weather_measurements
    weather_measurements_importer = WeatherMeasurementsImporter.new('test/support/weatherdata_excerpt.csv')
    weather_measurements_importer.call
  end
end
