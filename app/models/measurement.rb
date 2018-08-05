# frozen_string_literal: true

class Measurement < ApplicationRecord
  belongs_to :station

  validates_presence_of :datetime,
                        :value,
                        :type,
                        :station_id,
                        :unit

  scope :most_recent, -> { where(most_recent: true) }
  scope :less_than_week_old, -> { where('datetime >= ?', 1.week.ago) }
  scope :measured_less_than_day_ago, -> { where('datetime >= ?', 1.day.ago) }

  def serialize
    {
      datetime: datetime,
      value: value,
      measurementType: type,
      stationId: station_id,
      unit: unit
    }
  end
end
