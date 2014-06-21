# encoding: utf-8
#
require 'test_helper'

class CapybaraTest < ActionDispatch::IntegrationTest
  test '1' do
    visit '/'
    sleep 2
    save_screenshot '1.png'
  end
end
