class CreateWeatherMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_measurements do |t|
      t.string :number
      t.float :air_temp
      t.float :sun_time
      t.float :wind_speed
      t.float :rain_amount
      t.datetime :datetime

      t.references :weather_station, index: true
      t.timestamps
    end
  end
end
