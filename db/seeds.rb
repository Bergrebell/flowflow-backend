s = Station.new
s.number = 2009
s.name = 'Porte du Scex'
s.water_body_name = 'Rhône'
s.water_body_type = 'river'
s.easting = '557660'
s.northing = '133280'
s.save!

sea = SeaLevel.new
sea.datetime = '2017-07-21T15:40:00'
sea.value = 375.70
sea.warn_level = nil
sea.max_24h = 375.72
sea.warn_level_24h = nil
sea.station = s
sea.save!

d = Discharge.new
d.datetime = '2017-07-21T15:40:00'
d.value = 255
d.warn_level = 1
d.max_24h = 286
d.warn_level_24h = 1
d.station = s
d.save!

t = Temperature.new
t.datetime = '2017-07-21T15:40:00'
t.value = 9.4
t.warn_level = nil
t.max_24h = 9.4
t.warn_level_24h = nil
t.station = s
t.save!

