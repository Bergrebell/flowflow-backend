class Api::MeasurementsController < ApplicationController
  def index
    mg = Measurement
      .most_recent
      .map(&:serialize)
      .group_by {|m| m[:stationId]}

    render json: mg
  end
end
