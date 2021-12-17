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
    # => station.element_children
    # <parameter name="Pegel m ü. M." unit="m" field-name="BAFU_2232_PegelRadarunten">
    #       <datetime>2021-12-16T21:30:00+01:00</datetime>
    #       <value>1297.675</value>
    #       <max-24h>1297.678</max-24h>
    #       <mean-24h>1297.660</mean-24h>
    #       <min-24h>1297.654</min-24h>
    # </parameter>
    # <parameter name="Abfluss m3/s" unit="m3/s" field-name="BAFU_2232_AbflussRadarunten">
    #       <datetime>2021-12-16T21:30:00+01:00</datetime>
    #       <value hq-class="1" quantile-class="3" warn-level-class="1">0.576</value>
    #       <max-24h hq-class="1" quantile-class="3" warn-level-class="1">0.593</max-24h>
    #       <mean-24h>0.494</mean-24h>
    #       <min-24h>0.459</min-24h>
    # </parameter>
    # <parameter name="Wassertemperatur" unit="°C" field-name="BAFU_2232_Wassertemperatur1">
    #       <datetime>2021-12-16T21:30:00+01:00</datetime>
    #       <value temperature-class="1">1.240</value>
    #       <max-24h temperature-class="1">1.820</max-24h>
    #       <mean-24h>1.473</mean-24h>
    #       <min-24h>1.220</min-24h>
    # </parameter>
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
    m.datetime = child.at_css('datetime')&.content
    m.value = child.at_css('value')&.content
    m.warn_level = child.at_css('value')&.attributes['warn-level-class']&.value
    m.max_24h = child.at_css('max-24h')&.content
    m.warn_level_24h = child.at_css('max-24h')&.attributes['warn-level-class']&.value
  end

  def set_type(child, m)
    case child.attr('name')
      when 'Pegel m ü. M.'
        m.type = 'SeaLevel'
        m.unit = 'm ü. M.'
      when 'Wassertemperatur'
        m.type = 'Temperature'
        m.unit = '°C'
      when 'Abfluss m3/s'
        m.type = 'Discharge'
        m.unit = 'm3/s'
    else
      puts "*** WARNING: Could not match atrribute with name: #{name}."
    end
  end
end
