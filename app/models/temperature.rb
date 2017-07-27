# parameter-type: 3
class Temperature < Measurement
  UNIT = '°C'.freeze

  def self.unit
    UNIT
  end
end
