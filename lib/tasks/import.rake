namespace :import do
  desc 'imports waters and weather stations and measurements'
  task all: :environment do
    Rake::Task['waters:import_stations_and_measurements'].invoke
    Rake::Task['weather:import_stations_and_measurements'].invoke
  end
end
