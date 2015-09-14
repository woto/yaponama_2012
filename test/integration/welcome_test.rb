require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest
  test 'Набрав символ A мы не должны увидеть A.B.S' do
    Capybara.reset!
    visit '/'
    fill_in 'q_name_cont', with: 'A'
    assert has_text? 'ACURA'
    assert has_no_text? 'A.B.S.'
  end
end
