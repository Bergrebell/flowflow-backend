class StationSerializer < ActiveModel::Serializer
  attributes :id, :name, :water_body_name
  belongs_to :station
end
