class AddStationIdToWeatherStation < ActiveRecord::Migration[5.0]
  def change
    add_reference :weather_stations, :station, index: true
    add_foreign_key :weather_stations, :stations
  end
end
