require 'open-uri'

class ImportXmlJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'Starting to fetch data...'

    doc = Nokogiri::XML(
      open(
        'https://www.hydrodata.ch/data/hydroweb.xml',
        http_basic_authentication: [
            Rails.application.secrets.HYDRODATA_USERNAME,
            Rails.application.secrets.HYDRODATA_PASSWORD
         ]
      )
    )

    stations = doc.xpath('//station')

    stations.each do |station|
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
              m.unit = child.attributes['unit'].value
              m.save!
            rescue => exception
              puts "*** ERROR: Could not save measurement with Station: #{station.name} and name: #{m.name}(#{exception})"
            end
          end
        end
      rescue => exception
        puts "*** ERROR: Could not save Station with name: #{station.name} (#{exception})"
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
