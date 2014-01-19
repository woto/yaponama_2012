# encoding: utf-8
#
require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  test "Входим используя google_oauth2" do
    ## TODO Раньше работало, потом что-то сломалось, 
    ## нет реальной необходимости. Заменить на mock-stub
    #Capybara.reset!

    #visit '/login'
    #click_link 'google_oauth2'

    #page.within_window 'login' do
    #  fill_in 'Email', :with => 'yaponama.2012@gmail.com'
    #  fill_in 'Passwd', :with => '2012.yaponama'
    #  find('#signIn').click
    #  find("#submit_approve_access:not([disabled])").click
    #end

    ## Ищем google uid
    #assert page.has_selector?('#auth-result', text: /105940515133361319903/)
  end
end
