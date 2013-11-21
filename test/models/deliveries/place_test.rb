# encoding: utf-8
#
require 'test_helper'

class Deliveries::PlaceTest < ActiveSupport::TestCase
  test 'Тестируем validators/css_hex_color_validator' do
    place = Deliveries::Place.new(active_fill_color: '#G00000')
    place.valid?
    assert_equal ["указан не правильный HEX код цвета"], place.errors[:active_fill_color]

    place.active_fill_color = '#150AFD'
    place.valid?
    assert_empty place.errors[:active_fill_color]
  end

end
