require 'test_helper'

class BrowserTimezone < ActionDispatch::IntegrationTest
  test 'adsf' do
    visit '/'
    visit '/'
    time_zone = URI.decode get_me_the_cookie('browser.timezone')[:value]
    tz = ActiveSupport::TimeZone.new(time_zone)
    assert tz
  end
end
