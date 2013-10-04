# encoding: utf-8

require 'test_helper'

class TimeZoneCheckboxTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'У first_user по-умолчанию выбран час. пояс вручную - Красноярское время' do
    auth('+7 (123) 123-12-31', '1231231231')
    visit '/user/edit'
    assert has_no_css? '#user_russian_time_zone_auto_id'
    assert has_select? 'user_russian_time_zone_manual_id', selected: 'Красноярское время'
  end

  test 'У stan по-умолчанию выбран час. пояс автоматом - Иркутское время. Но в процессе аутентификации выставляется Московское.' do
    auth('+7 (333) 333-33-33', '3333333333')
    visit '/user/edit'
    assert has_no_css? '#user_russian_time_zone_manual_id'
    assert has_select? 'user_russian_time_zone_auto_id', selected: 'Московское время', disabled: true
  end

  test 'При щелчке на Автоматически должен показаться соответствующий select' do
    skip
  end

  test 'При щелчке на Вручную должен показаться соответствующий select' do
    skip
  end

end
