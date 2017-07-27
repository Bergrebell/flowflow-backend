# parameter-type: 2
class SeaLevel < Measurement
  UNIT = 'm ü. M.'.freeze

  def self.unit
    UNIT
  end
end
