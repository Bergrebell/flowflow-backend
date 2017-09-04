class CreateWeatherStations < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_stations do |t|
      t.string :number
      t.string :village
      t.integer :easting
      t.integer :northing

      t.timestamps
    end
  end
end
