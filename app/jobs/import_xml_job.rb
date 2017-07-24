require 'open-uri'

class ImportXmlJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'Starting to fetch data...'

    doc = File.open('test/support/hydrodata_excerpt.xml') { |f| Nokogiri::XML(f) }
    stations = doc.xpath('//station')
    stations.each do |station|
      s = Station.new
      s.number          = station.attributes['number'].value
      s.name            = station.attributes['name'].value
      s.water_body_name = station.attributes['water-body-name'].value
      s.water_body_type = station.attributes['water-body-type'].value
      s.easting         = station.attributes['easting'].value
      s.northing        = station.attributes['northing'].value
      s.save!

      station.element_children.each do |child|
        if child.name == 'parameter'

          m = Measurement.new
          set_type(child, m)

          child.children.each do |child|

            case child.name
              when 'datetime'
                #get datetime
                m.datetime = child.children.text
              when 'value'
                #get warn_level & value
                m.value = child.text&.to_i
                m.warn_level = child.values[1]
              when 'max-24h'
                #get warn-level & value
                m.max_24h = child.text&.to_i
                m.warn_level_24h = child.values[1]
            end
          end
          m.station = s
          m.save!
        end
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
