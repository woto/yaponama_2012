require 'test_helper'

class TimeTest < ActionDispatch::IntegrationTest
  test 'Набрав символ A мы не должны увидеть A.B.S' do
    Capybara.reset!
    visit '/'
    fill_in 'name', with: 'A'
    assert has_text? 'ACURA'
    assert has_no_text? 'A.B.S.'
    save_screenshot '1.png', full: true
  end
end
