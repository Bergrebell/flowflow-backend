require 'csv'

class WeatherImporter

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

    weather_data = CSV.parse(File.readlines(@doc)
                  .drop(2)
                  .join, headers: true, col_sep: '|')

    begin

    rescue => exception
      "*** ERROR: Could not save Station with name: #{station.name} (#{exception})"
    end

  end

end
