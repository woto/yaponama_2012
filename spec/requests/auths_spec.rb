require 'spec_helper'

describe "Auths", :js => true do
  describe "try to login", :js => true do
    it "works! (now write some real specs)", :js => true do
      visit '/login'
      click_link 'google_oauth2'

      window = page.driver.browser.window_handles.last

      page.within_window window do
        fill_in 'Email', :with => 'yaponama.2012@gmail.com'
        fill_in 'Passwd', :with => '2012.yaponama'
        find('#signIn').click
        find("#submit_approve_access:not([disabled])").click
      end

      page.should have_selector('.hide', visible: false, text: /yaponama/)

    end
  end
end
