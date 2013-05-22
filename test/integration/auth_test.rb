# encoding: utf-8

require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  test "Входим используя google_oauth2" do

    visit '/login'
    click_link 'google_oauth2'

    window = page.driver.browser.window_handles.last

    page.within_window window do
      fill_in 'Email', :with => 'yaponama.2012@gmail.com'
      fill_in 'Passwd', :with => '2012.yaponama'
      find('#signIn').click
      find("#submit_approve_access:not([disabled])").click
    end

    assert page.has_css?('.hide', visible: false, text: /yaponama/)

    Capybara.reset_session!
  end
end
