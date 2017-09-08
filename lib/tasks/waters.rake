require 'open-uri'

namespace :waters do
  desc 'imports water stations and measurements'
  task import_stations_and_measurements: :environment do
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

  desc 'imports missing temperatures to lakes'
  task import_temperatures_to_lakes: :environment do
    doc = Nokogiri::HTML(
      open('http://meteonews.ch/de/Artikel/Lakes/CH/de')
    )
    LakeTemperatureImporter.new(doc).call
  end

  desc 'removes measurements that are older than four days from database'
  task remove_old_measurements: :environment do
    Measurement.where('created_at < ?', 4.day.ago).delete_all
  end
end
