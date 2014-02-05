# encoding: utf-8
#
require 'test_helper'

class TalkSellerReceiveTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в публичной зоне.' do
    node do
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit '/'

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      text = 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в публичной зоне'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#broadcast-message', visible: false).has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение менеджеру, когда тот находится в публичной зоне' do
    node do
      first_admin = somebodies(:first_admin)
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit '/'

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{first_admin.id}"
      text = 'Пользователь отправляет сообщение менеджеру, когда тот находится в публичной зоне'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#talk-button-show').has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в админке в своем профиле' do
    node do
      first_admin = somebodies(:first_admin)
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{first_admin.id}"

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      text = 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в админке в своем профиле'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 1
      assert find('#broadcast-message', visible: false).has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение менеджеру, когда тот находится в админке в своем профиле' do
    node do
      first_admin = somebodies(:first_admin)
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{first_admin.id}"

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{first_admin.id}"
      text = 'Пользователь отправляет сообщение менеджеру, когда тот находится в админке в своем профиле'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 1
      assert find('#talk-button-show').has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в админке в профиле третьего пользователя' do
    node do
      first_admin = somebodies(:first_admin)
      first_user = somebodies(:first_user)

      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{first_user.id}"

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      text = 'Пользователь отправляет сообщение всем, когда наблюдаемый менеджер находится в админке в профиле третьего пользователя'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#broadcast-message', visible: false).has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение менеджеру, когда тот находится в админке в профиле третьего пользователя' do
    node do
      first_admin = somebodies(:first_admin)
      first_user = somebodies(:first_user)

      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{first_user.id}"

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{first_admin.id}"
      text = 'Пользователь отправляет сообщение менеджеру, когда тот находится в админке в профиле третьего пользователя'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#private-message', visible: false).has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение всем, когда у наблюдаемого менеджера нет кнопки чата (находится в списке пользователей)' do
    node do
      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit '/admin'

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      text = 'Пользователь отправляет сообщение всем, когда у наблюдаемого менеджера нет кнопки чата (находится в списке пользователей)'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#broadcast-message', visible: false).has_content?(text)
    end
  end

  test 'Пользователь отправляет сообщение менеджеру, когда нет кнопки чата (находится в списке пользователей)' do
    node do
      first_admin = somebodies(:first_admin)
      first_user = somebodies(:first_user)

      Capybara.session_name = :first
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin"

      Capybara.session_name = :second
      visit '/'
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{first_admin.id}"
      text = 'Пользователь отправляет сообщение менеджеру, когда нет кнопки чата (находится в списке пользователей)'
      fill_talk text
      click_button 'talk-submit'

      Capybara.session_name = :first
      sleep 2
      assert find('#private-message', visible: false).has_content?(text)
    end
  end

end
