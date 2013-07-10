# encoding: utf-8

require 'test_helper'

class NotifySoundTogglerTest < ActionDispatch::IntegrationTest

  test "Если мы щелкаем на кнопке выключения звука то в базе у пользователя audio должен стать false, а при дальнейшем переходе на другую страницу состояние должно сохраниться" do

    id = users(:first_user).id

    Capybara.reset!
    auth('1231231231', '1231231231')
    find('#talk-button-show').click
    assert_equal true, User.find(id).sound
    assert page.has_css?('#play-sound-on-new-message[data-value="true"]')
    first('.notify-sound-switcher').click
    sleep(1)
    visit '/'
    assert_equal false, User.find(id).sound
    assert page.has_css?('#play-sound-on-new-message[data-value="false"]')
    #assert page.has_css?('.notify-sound-switcher:not(.active)')
  end

end
