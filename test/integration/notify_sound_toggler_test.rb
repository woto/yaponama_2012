# encoding: utf-8
#
require 'test_helper'

class NotifySoundTogglerTest < ActionDispatch::IntegrationTest

  test "Если мы щелкаем на кнопке выключения звука то в базе у пользователя audio должен стать false, а при дальнейшем переходе на другую страницу состояние должно сохраниться" do

    id = somebodies(:first_user).id

    Capybara.reset!
    auth('1231231231', '1231231231')

    # Щелкаем на кнопке службы поддержки
    find('#talk-button-show').click

    # Убеждаемся, что звуковое оповещение включено
    assert has_css?('#play-sound-on-new-message[data-value="true"]', visible: false)
    assert_equal true, User.find(id).sound

    # Выключаем
    sleep 1
    find('.notify-sound-toggler-link', visible: true).click

    # Отправляется post к серверу, и только после его ответа ждем, текст меняется на true. Ждем его появления
    sleep 1
    assert assert_selector('#sound-toggled', text: 'true', visible: false)

    # Перегружаем страницу
    visit '/'

    # Убеждаемся, что теперь звуковое оповещение выключено
    assert has_css?('#play-sound-on-new-message[data-value="false"]', visible: false)
    assert_equal false, User.find(id).sound
    #assert page.has_css?('.notify-sound-switcher:not(.active)')
  end

    #save_screenshot '2.png', full: true

end
