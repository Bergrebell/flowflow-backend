class Api::StationsController < ApplicationController
  def index
    stations = Station.all.as_json(only: [:id, :name, :water_body_type])
    render json: stations
  end
end
