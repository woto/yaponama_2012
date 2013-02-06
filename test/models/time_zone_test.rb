# encoding: utf-8
require 'test_helper'

class TimZoneTest < ActiveSupport::TestCase

  test 'Временная зона без должного заполнения полей должна быть не корректна' do
    tz = FactoryGirl.build(:time_zone)
    tz.valid?
    assert tz.errors.include?(:time_zone)
    assert tz.errors.include?(:utc_offset_hours)
    assert tz.errors.include?(:utc_offset_minutes)
  end

end
