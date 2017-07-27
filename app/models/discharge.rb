# parameter-type: 10
class Discharge < Measurement
  UNIT = 'm3/s'.freeze

  def self.unit
    UNIT
  end
end
