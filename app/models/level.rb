# parameter-type: 1
class Level < Measurement
  UNIT = 'm'.freeze

  def self.unit
    UNIT
  end
end
