require 'csv'

class LakeTemperatureImporter

  def initialize(document)
    @doc = document
  end

  def call
    ActiveRecord::Base.transaction do
      import_data
    end
  end

  def import_data
    puts 'Starting to add missing temperatures...'
    table = @doc.css('div.ModulePostArticle.ModulePost.modul .colcontent table tr')
    row_text = table.map do |row|
      row.text
    end

    row_text[1..-1].each do |attr|
      attributes_array = attr.split("\n")
      lake_name = attributes_array[1]
      lake_temperature = attributes_array[3].gsub(' °C', '')

      create_measurement(lake_name, lake_temperature)
    end
  end

  private

  def create_measurement(lake_name, lake_temperature)
    station_numbers_by_name(lake_name).each do |number|
      station = Station.find_by(number: number)
      return unless station
      station.measurements.create(
        datetime: Time.now,
        value:    lake_temperature,
        type:     'Temperature',
        unit:     '°C',
        most_recent: true
      )
    end
  end

  def station_numbers_by_name(lake_name)
    case lake_name
      when 'Bielersee'
        [2208]
      when 'Bodensee'
        [2032 ,2043]
      when 'Brienzersee'
        [2023]
      when 'Genfersee'
        [2027, 2028]
      when 'Greifensee'
        [2082]
      when 'Luganersee'
        [2022, 2074, 2101, 2021]
      when 'Murtensee'
        [2004]
      when 'Neuenburgersee'
        [2149, 2154]
      when 'Thunersee'
        [2093]
      when 'Vierwaldstätter See'
        [2025, 2207]
      when 'Walensee'
        [2118]
      when 'Zugersee'
        [2017]
      when 'Zürichsee'
        [2209, 2014]
    end
  end

end
