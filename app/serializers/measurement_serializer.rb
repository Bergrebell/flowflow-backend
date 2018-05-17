class MeasurementSerializer < ActiveModel::Serializer
  attributes :measured_at, :value

  def measured_at
    object.datetime
  end
end
