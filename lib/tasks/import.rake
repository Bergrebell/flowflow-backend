require 'open-uri'

namespace :import do
  desc 'Import xml from "https://www.hydrodata.ch/data/hydroweb.xml" into database'
  task bafu_hydrodata: :environment do
    doc = Nokogiri::XML(
      open(
        'https://www.hydrodata.ch/data/hydroweb.xml',
        http_basic_authentication: [
            Rails.application.secrets.HYDRODATA_USERNAME,
            Rails.application.secrets.HYDRODATA_PASSWORD
         ]
      )
    )

    BafuImporter.new(doc).call
  end

  desc 'Import csv from "http://data.geo.admin.ch/ch.meteoschweiz.swissmetnet/VQHA69.csv"'
  task meteoschweiz_weatherdata: :environment do

    open('tmp/weather_data.csv', 'wb') do |file|
      file << open('http://data.geo.admin.ch/ch.meteoschweiz.swissmetnet/VQHA69.csv').read
    end

    doc = open('tmp/weather_data.csv')
    WeatherMeasurementsImporter.new(doc).call

  end
end
