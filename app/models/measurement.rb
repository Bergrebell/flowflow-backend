class Measurement < ApplicationRecord
  belongs_to :station

  validates_presence_of :datetime,
                        :value,
                        :type,
                        :station_id,
                        :unit

  scope :most_recent, -> { where(most_recent: true) }
end
