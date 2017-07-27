class Measurement < ApplicationRecord
  belongs_to :station

  scope :most_recent, -> { where(most_recent: true) }
end
