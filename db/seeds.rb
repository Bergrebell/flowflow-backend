locarno = Station.find_by(name: 'Locarno')

(0..20).to_a.each do |e|
  Measurement.create!(
    datetime: DateTime.now - e,
    value: Random.rand(15..30),
    warn_level: nil,
    max_24h: 12,
    warn_level_24h: nil,
    type: 'Temperature',
    station: locarno,
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
    type: 'Discharge',
    station: locarno,
    most_recent: true,
    unit: 'm3/s',
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
    station: locarno,
    most_recent: true,
    unit: 'm ü. M.',
    created_at: DateTime.now - e
  )
end
