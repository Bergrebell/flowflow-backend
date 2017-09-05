require 'test_helper'

class ConnectWeatherToWaterStationsServiceTest < ActiveJob::TestCase

  # setup do
  #
  # end

  test 'should build station data' do
    ConnectWeatherToWaterStationsService.new(Station.all).call
  end

end
