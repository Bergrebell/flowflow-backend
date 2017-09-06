class AddWeatherStationIdToStation < ActiveRecord::Migration[5.0]
  def change
    add_reference :stations, :weather_station, index: true
    add_foreign_key :stations, :weather_stations
  end
end
