# parameter-type: 10
class Discharge < Measurement

  def serialize
    {
      datetime: datetime,
      value: value,
      measurementType: type,
      stationId: station_id,
      unit: unit,
      warnLevel: warn_level
    }
  end

end
