weather_zürich = WeatherStation.find_or_create_by(
  number: 'wbz',
  village: 'Near Zürich',
  easting: 551800,
  northing: 119700
)

weather_zürich_measurement = WeatherMeasurement.find_or_create_by(
  number: "ZHL",
  air_temp: 16.0,
  sun_time: 0.0,
  wind_speed: 15.8,
  rain_amount: 0.0,
  datetime: DateTime.now - 1,
  weather_station: weather_zürich
)

zh = Station.find_or_create_by(
  number: 1111,
  name: 'Zürich - Limmat',
  water_body_name: "Limmat",
  water_body_type: "river",
  easting: 551800,
  northing: 119700,
  weather_station: weather_zürich
)

(0..20).to_a.each do |e|
  Measurement.create!(
    datetime: DateTime.now - e,
    value: Random.rand(15..30),
    warn_level: nil,
    max_24h: 12,
    warn_level_24h: nil,
    type: 'Temperature',
    station: zh,
    most_recent: true,
    unit: '°C',
    created_at: DateTime.now - e
  )
end

(0..20).to_a.each do |e|
  Measurement.create!(
    datetime: DateTime.now - e,
    value: Random.rand(1..120),
    warn_level: nil,
    max_24h: 12,
    warn_level_24h: nil,
    type: 'DischargeLiter',
    station: zh,
    most_recent: true,
    unit: 'l/s',
    created_at: DateTime.now - e
  )
end

(0..20).to_a.each do |e|
  Measurement.create!(
    datetime: DateTime.now - e,
    value: Random.rand(1..12),
    warn_level: nil,
    max_24h: 12,
    warn_level_24h: nil,
    type: 'SeaLevel',
    station: zh,
    most_recent: true,
    unit: 'm ü. M.',
    created_at: DateTime.now - e
  )
end
