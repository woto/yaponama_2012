# encoding: utf-8
#
require 'spec_helper'

describe TimeZone do

  it 'Пустой time_zone не корректен' do
    should have(1).error_on :time_zone
    should have(1).error_on :utc_offset_hours
    should have(1).error_on :utc_offset_minutes
  end

  it 'Минимально заполненный time_zone корректен' do
    FactoryGirl.build(:minimal_valid_time_zone).should be_valid
  end

end
