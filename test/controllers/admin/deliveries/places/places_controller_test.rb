# encoding: utf-8

require 'test_helper'

class Admin::Deliveries::Places::PlacesControllerTest < ActionController::TestCase
  test 'Тестируем фактически css_hex_color_validator' do
    first_admin = users(:first_admin)
    cookies['auth_token'] = first_admin.auth_token
    post :create, :deliveries_places_place => {active_fill_color: '#G00000'}
    assert_equal ["указан не правильный HEX код цвета"], assigns[:deliveries_places_place].errors[:active_fill_color]

    post :create, :deliveries_places_place => {active_fill_color: '#150AFD'}
    assert_empty assigns[:deliveries_places_place].errors[:active_fill_color]
  end
end

