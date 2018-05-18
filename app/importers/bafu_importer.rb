class BafuImporter

  def initialize(xml_document)
    @doc = xml_document
  end

  def call
    ActiveRecord::Base.transaction do
      import_data
    end
  end

  def import_data
    puts 'Starting to fetch waters_data...'

    stations = @doc.xpath('//station')

    stations.each do |station|
      begin
        station_object = Station.find_or_initialize_by(number: station.attributes['number'].value)
        station_object.name               = station.attributes['name'].value
        station_object.water_body_name    = station.attributes['water-body-name'].value
        station_object.water_body_type    = station.attributes['water-body-type'].value
        station_object.easting            = station.attributes['easting'].value
        station_object.northing           = station.attributes['northing'].value
        station_object.weather_station_id = set_weather_station_id(station_object).id
        station_object.save!

        add_measurements(station, station_object)
      rescue => exception
        "*** ERROR: Could not save Station with name: #{station.name} (#{exception})"
      end
    end
  end

  def add_measurements(station, station_object)
    station.element_children.each do |child|
      if child.name == 'parameter'
        begin
          m = Measurement.new
          set_type(child, m)
          set_attributes(child, m)
          m.station     = station_object
          m.most_recent = true
          m.save!
        rescue => exception
          message = "*** ERROR: Could not save measurement with Station: #{station.name} and name: #{m.name}(#{exception})"
          say message
        end
      end
    end
  end

  def set_weather_station_id(station)
    weather_station_location = [station.easting, station.northing]
    ConnectWaterToWeatherStationsService.new(weather_station_location).nearest_weather_station
  end

  def set_attributes(child, m)
    child.children.each do |child|
      case child.name
        when 'datetime'
          m.datetime = child.children.text
        when 'value'
          m.value      = child.text&.to_f
          m.warn_level = child.values[1]
        when 'max-24h'
          m.max_24h        = child.text&.to_f
          m.warn_level_24h = child.values[1]
      end
    end
  end

  def set_type(child, m)
    case child.attributes['type'].value
      when '1'
        m.type = 'Level'
        m.unit = 'm'
      when '2'
        m.type = 'SeaLevel'
        m.unit = 'm ü. M.'
      when '3'
        m.type = 'Temperature'
        m.unit = '°C'
      when '10'
        m.type = 'Discharge'
        m.unit = 'm3/s'
      when '22'
        m.type = 'DischargeLiter'
        m.unit = 'l/s'
    end
  end
end
