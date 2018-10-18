# frozen_string_literal: true

require 'test_helper'

class BafuImporterTest < ActiveJob::TestCase
  setup do
    import_waters
  end

  test 'imports correct data' do
    assert_equal 240, Station.count
    assert_equal 518, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 9.4, Station.find_by(number: '2009').temperatures.first.value
  end
end
