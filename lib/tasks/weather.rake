require 'open-uri'

namespace :weather do
  desc 'imports weather stations and measurements'
  task import_stations_and_measurements: :environment do
    Rake::Task['weather:stations'].invoke
    Rake::Task['weather:measurements'].invoke
  end

  desc 'Imports weather measurements'
  task measurements: :environment do
    open('tmp/weather_data.csv', 'wb') do |file|
      file << open('https://data.geo.admin.ch/ch.meteoschweiz.messwerte-aktuell/VQHA80.csv').read
    end

    doc = open('tmp/weather_data.csv')
    WeatherMeasurementsImporter.new(doc).call
  end

  desc 'Imports weather stations from file'
  task stations: :environment do
    ws = WeatherStationsImporter.new('lib/support/weather_stations.csv')
    ws.call
  end
end
