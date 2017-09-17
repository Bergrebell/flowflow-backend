# parameter-type: 22
class DischargeLiter < Measurement

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
