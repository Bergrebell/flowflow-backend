require 'csv'

class WeatherStationsImporter

  def initialize(csv_document)
    @doc = csv_document
  end

  def call
    ActiveRecord::Base.transaction do
      import_data
    end
  end

  def import_data
    puts 'Starting to fetch weather_stations...'

    weather_stations = CSV.table(@doc, headers: true, col_sep: ';')

    weather_stations.each do |ws|
      begin
        wss          = WeatherStation.find_or_initialize_by(number: ws[:number])
        wss.village  = ws[:village]
        wss.easting  = ws[:easting]
        wss.northing = ws[:northing]
        wss.save
      rescue => exception
        puts "*** ERROR: Could not save WeatherStation with number: #{ws[:number]} (#{exception})"
      end
    end
  end

end
