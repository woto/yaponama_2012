# encoding: utf-8
#
require 'test_helper'

class NotifySoundTest < ActionDispatch::IntegrationTest
  test 'Если пользователь онлайн и ему приходит сообщение и окно чата свернуто, то должен появится notify' do
  end

  test 'Если у пользователя включена пимпочка звукового оповещения при получении нового сообщения, то должен проиграться звук.' do
    Capybara.reset!

    node do
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      assert has_css? ".alert-success", text: "Вы успешно вошли."

      click_link 'talk-button-show-inside'

      Capybara.session_name = :second
      auth('+7 (444) 444-44-44', '4444444444')
      assert has_css? ".alert-success", text: "Вы успешно вошли."

      click_link 'talk-button-show-inside'

    end
  end
end
