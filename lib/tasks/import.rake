namespace :import do
  desc 'imports waters and weather stations and measurements'
  task all: :environment do
    Rake::Task['weather:import_stations_and_measurements'].invoke
    Rake::Task['waters:import_all_waters'].invoke

    Rake::Task['housekeeping:export'].invoke
    Rake::Task['housekeeping:db'].invoke
  end
end
