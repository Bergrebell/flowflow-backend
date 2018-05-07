require 'open-uri'

namespace :waters do
  desc 'import water stations, measurements and additional lake temperatures'
  task import_all_waters: :environment do
    Rake::Task['waters:set_most_recent_false'].invoke
    Rake::Task['waters:import_stations_and_measurements'].invoke
    Rake::Task['waters:import_temperatures_to_lakes'].invoke
  end

  desc 'imports water stations and measurements'
  task import_stations_and_measurements: :environment do
    doc = Nokogiri::XML(
      open(
        'https://www.hydrodata.ch/data/hydroweb.xml',
        http_basic_authentication: [
            Rails.application.credentials.HYDRODATA_USERNAME,
            Rails.application.credentials.HYDRODATA_PASSWORD
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

  desc 'sets most_recent to false on all measurements'
  task set_most_recent_false: :environment do
    puts 'Starting to set most_recent to false for old measurements...'
    Measurement.update_all(most_recent: false)
  end

  desc 'removes measurements that are older than a week from database'
  task remove_old_measurements: :environment do
    Measurement.where('created_at < ?', 7.day.ago).delete_all
  end
end
