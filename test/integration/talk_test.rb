# encoding: utf-8

require 'test_helper'

class TalkTest < ActionDispatch::IntegrationTest

  test "Если мы щелкаем на кнопке выключения звука то в базе у пользователя audio должен стать false, а при дальнейшем переходе на другую страницу кнопка должна потерять класс active" do

    id = users(:first_user).id

    Capybara.reset!
    auth('1231231231', '1231231231')
    find('#talk-button-show').click
    assert_equal true, User.find(id).sound
    assert page.has_css?('#sound.active')
    find('#sound').click
    sleep(1)
    visit '/'
    assert_equal false, User.find(id).sound
    assert page.has_css?('#sound:not(.active)')
  end

end
