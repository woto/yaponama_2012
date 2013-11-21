# encoding: utf-8
#
require 'test_helper'

class GoogleMapsTest < ActionDispatch::IntegrationTest
  test 'Первый тест Google Maps' do
    visit "/deliveries" 
    sleep(5)
    page.execute_script "$('#clientMap').scroll(0,10000)"
    sleep 2
    #page.save_screenshot('1.png')
  end
end
