class Api::MeasurementsController < ApplicationController
  def index
    m = Measurement.most_recent.select(:id, :station_id, :type, :value, :datetime)
    mg = m.group_by {|m| m.station_id}
    render json: mg.to_json
  end
end
