require 'open-uri'

class ImportXmlJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'Starting to fetch data...'

    doc = Nokogiri::HTML(open("https://www.hydrodaten.admin.ch/en/current-situation-table-discharge-and-water-levels.html"))
    trs = doc.search('tr')
    trs.each do |tr|
      attributes = tr.attributes

      if attributes.key?("data-station-id") && attributes.key?("data-station-name")
        id = attributes["data-station-id"].value
        name = attributes["data-station-name"].value
        Station.find_or_create_by(station_id: id, name: name)
      end

    end
  end
end
