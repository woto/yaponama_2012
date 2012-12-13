require 'spec_helper'

describe "TestControllers", :js => true do
  describe "GET /test_controllers", :js => true do
    it "works! (now write some real specs)", :js => true do
      full_filled_user = FactoryGirl.create(:full_filled_user)

      puts '1'
 
      visit admin_user_products_path(full_filled_user)

      # Найти первый нужный чекбокс
      checkbox = first(:css, 'table input[type=checkbox]').native.attribute('id')
      check checkbox

      first(:css, ".btn.btn-primary.dropdown-toggle").click

      first(:css, ".dropdown-menu>li>a").click

      #.dropdown-menu>li>a

      save_and_open_page
      #debugger
      #save_screenshot('screenshot.png')
      get test_controllers_path
      response.status.should be(200)
    end
  end
end




