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
                  .drop(2)
                  .join, headers: true, col_sep: '|')

    weather_measurements.each do |wm|
      begin
        m             = WeatherMeasurement.find_or_initialize_by(number: wm['stn'])
        m.air_temp    = wm['tre200s0']
        m.sun_time    = wm['sre000z0']
        m.wind_speed  = wm['fu3010z0']
        m.rain_amount = wm['rre150z0']
        m.weather_station = WeatherStation.find_by(number: wm['stn'])
        m.datetime = wm['time'].to_datetime
        m.save
      rescue => exception
        "*** ERROR: Could not save WeatherMeasurement with number: #{wm.number} (#{exception})"
      end
    end
  end
end
