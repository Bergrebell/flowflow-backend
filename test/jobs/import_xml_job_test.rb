require 'test_helper'

class ImportXmlJobTest < ActiveJob::TestCase
  setup do
    @job = ImportXmlJob.new
    @sample_path = 'test/support/hydrodata_excerpt.xml'
  end

  test 'perform' do
    @job.perform(@sample_path)
    assert_equal 240, Station.count
    assert_equal 508, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 9.0, Station.find_by(number: '2009').temperatures.first.value
  end
end
