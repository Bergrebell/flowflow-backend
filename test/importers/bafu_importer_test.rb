# frozen_string_literal: true

require 'test_helper'

class BafuImporterTest < ActiveJob::TestCase
  setup do
    import_waters
  end

  test 'imports correct data' do
    assert_equal 235, Station.count
    assert_equal 483, Measurement.count

    assert_equal 'Porte du Scex', Station.find_by(number: '2009').name
    assert_equal 2.8, Station.find_by(number: '2009').temperatures.first.value
  end
end
