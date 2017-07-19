w = Water.find_or_create_by(name: 'Rhein')
w.save!

s = Station.find_or_create_by(name: 'Rheinkraftwerk Bad Säckingen')
s.station_id = 123
s.water = w
s.save!

m = Measurement.new
m.quantity = 0.76
m.maximum_quantity = 0.81
m.reading_time = Time.now
m.station = s
m.save!
