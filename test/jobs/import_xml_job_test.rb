require 'test_helper'
require 'webmock/minitest'

class ImportXmlJobTest < ActiveJob::TestCase

  setup do
    @job = ImportXmlJob.new
  end

  test 'perform' do
    stub_request(:get, "https://www.hydrodata.ch/data/hydroweb.xml")
      .to_return(:status => 200, :body => open('test/support/hydrodata_excerpt.xml'))

    @job.perform

    assert_equal 240, Station.count
    assert_equal 508, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 9.0, Station.find_by(number: '2009').temperatures.first.value
  end

end
