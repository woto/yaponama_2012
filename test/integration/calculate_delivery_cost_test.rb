# encoding: utf-8
#
require 'test_helper'

class CalculateDeliveryCostTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Гость заходит на страницу доставки и нажимает кнопку Расчитать не заполнив ничего' do
    visit '/deliveries'
    skip
  end

end
