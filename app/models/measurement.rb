class Measurement < ApplicationRecord
  belongs_to :station

  validates_presence_of :datetime,
                        :value,
                        :type,
                        :station_id,
                        :unit

  scope :most_recent       , -> { where(most_recent: true) }
  scope :less_than_week_old, -> { where('created_at >= ?', 1.week.ago) }

  def serialize
    {
      datetime: datetime,
      value: value,
      measurementType: type,
      stationId: station_id,
      unit: unit,
    }
  end

end
