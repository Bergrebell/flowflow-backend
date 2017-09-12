# {
#   waterlevel: [{
#     value: 125, // aktueller wert
#     mean_24: 120,
#     datetime:
#   }, {}, {}, {}],
#   temperatur: []
# }
class HistoryService

  def initialize(station)
    @station = station
  end

  def call
    serialize
  end

  private

  def serialize
    measurement_types = %w(temperatures discharges sea_levels levels discharge_liters)
    measurements = {}
    measurement_types.each do |m|
      measurements[m.camelize.downcase] = @station.send(m).less_than_week_old.map do |d|
        {
          value: d.value,
          weeklyAverage: weekly_average(m),
          datetime: d.datetime
        }
      end
    end
    measurements
  end

  def weekly_average(m)
    @station.send(m).less_than_week_old.average(:value).to_f
  end

end
