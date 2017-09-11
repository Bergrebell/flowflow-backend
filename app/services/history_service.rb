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
    # temperatures          = @station.temperatures
    # type_sea_levels       = @station.sea_levels
    # type_levels           = @station.levels
    # type_discharge_liters = @station.discharge_liters
    discharge_hash
  end

  def discharge_hash
    type_discharge_mean_week = @station.discharges.less_than_week_old.average(:value).to_f
    @station.discharges.map do |d|
      {
        value: d.value,
        mean_7: type_discharge_mean_week,
        datetime: d.datetime
      }
    end
  end


end
