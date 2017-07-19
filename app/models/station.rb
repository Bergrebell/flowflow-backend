class Station < ApplicationRecord
  belongs_to :water
  has_many :measurements
end
