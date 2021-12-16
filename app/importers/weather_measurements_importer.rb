# frozen_string_literal: true

require 'csv'

class WeatherMeasurementsImporter
  def initialize(csv_document)
    @doc = csv_document
  end

  def call
    ActiveRecord::Base.transaction do
      import_data
    end
  end

  def import_data
    puts 'Starting to fetch weather_data...'

    weather_measurements = CSV.parse(File.readlines(@doc)
                  .join, headers: true, col_sep: ';')

    weather_measurements.each do |wm|
      m             = WeatherMeasurement.find_or_initialize_by(number: wm['Station/Location'])
      m.air_temp    = wm['tre200s0'] # Air temperature 2m above ground, in °C
      m.sun_time    = wm['sre000z0'] # Sunshine in min (within the last 10min)
      m.wind_speed  = wm['fu3010z0'] # Wind speed in km/h (average of the last 10min)
      m.rain_amount = wm['rre150z0'] # Precipitation in mm (within the last 10min)
      m.weather_station = WeatherStation.find_by(number: wm['Station/Location'])
      m.datetime = wm['Date'].to_datetime
      m.save
    rescue StandardError => exception
      "*** ERROR: Could not save WeatherMeasurement with number: #{wm.number} (#{exception})"
    end
  end
end
