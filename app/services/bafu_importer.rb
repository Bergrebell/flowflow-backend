class BafuImporter

  def initialize(xml_document)
    @doc = xml_document
  end

  def call
    puts 'Starting to fetch data...'

    #doc = File.open(hydrodata_file_path) { |f| Nokogiri::XML(f) } TODO

    stations = @doc.xpath('//station')

    stations.each do |station|
      if Station.find_by(number: )
      begin
        s = Station.find_or_initialize_by(number: station.attributes['number'].value)
        s.name            = station.attributes['name'].value
        s.water_body_name = station.attributes['water-body-name'].value
        s.water_body_type = station.attributes['water-body-type'].value
        s.easting         = station.attributes['easting'].value
        s.northing        = station.attributes['northing'].value
        s.save!

        station.element_children.each do |child|
          if child.name == 'parameter'
            begin
              m = Measurement.new
              set_type(child, m)
              set_attributes(child, m)
              m.station = s
              m.save!
            rescue => exception
              message = "*** ERROR: Could not save measurement with Station: #{station.name} and name: #{m.name}(#{exception})"
              say message
            end
          end
        end
      rescue => exception
        message = "*** ERROR: Could not save Station with name: #{station.name} (#{exception})"
        say message
      end
    end
  end

  def set_attributes(child, m)
    child.children.each do |child|
      case child.name
        when 'datetime'
          m.datetime = child.children.text
        when 'value'
          m.value      = child.text&.to_i
          m.warn_level = child.values[1]
        when 'max-24h'
          m.max_24h        = child.text&.to_i
          m.warn_level_24h = child.values[1]
      end
    end
  end

  def set_type(child, m)
    case child.attributes['type'].value
      when '1'
        m.type = 'Level'
      when '2'
        m.type = 'SeaLevel'
      when '3'
        m.type = 'Temperature'
      when '10'
        m.type = 'Discharge'
      when '22'
        m.type = 'DischargeLiter'
    end
  end
end
