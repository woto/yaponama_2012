# encoding: utf-8

require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  test 'Аутентифицированный пользователь может выйти' do
    authenticated_as('1111111111', '1111111111') do |administrator|
      #debugger
      get '/admin/users'
      assert_response 200
    end
  end

  test 'Если у пользователя выставлена опция logout_from_all_places_test, то его должно выкинуть с другого компьютера.' do
    Capybara.reset!

    login = '5555555555'
    password = '5555555555'

    Capybara.session_name = :first
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :second
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :first
    visit root_path
    assert has_css? '.alert-error'

  end

  test 'Если у пользотеля не выставлена опция logout_from_all_places_test, то его не должно выкинуть с другого компьютера.' do
    Capybara.reset!

    login = '4444444444'
    password = '4444444444'

    Capybara.session_name = :first
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :second
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :first
    visit root_path
    assert has_no_css? '.alert-error'

  end

  test 'Пользователь самостоятельно у себя в личном профиле нажимает: Выйти со всех компьютеров. (Факт. перегенирует auth_token)' do
    Capybara.reset!

    login = '4444444444'
    password = '4444444444'

    Capybara.session_name = :first
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :second
    auth(login, password)
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :first
    visit '/user'
    find('#talk-button-show').click
    find('#logout_from_all_places_user_path').click

    Capybara.session_name = :second
    visit root_path
    assert has_css? '.alert-error'

  end

  test 'Администратор щелкает у пользователя: Разлогинить пользователя со всех компьютеров. (Факт. перегенерирует auth_token)' do
    Capybara.reset!

    Capybara.session_name = :first
    auth('4444444444', '4444444444')
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    Capybara.session_name = :second
    auth('1111111111', '1111111111')
    assert has_css? ".alert-success", text: "Вы успешно вошли."
    visit admin_user_path(users(:mark_user))
    find('#admin_user_logout_from_all_places_path').click

    Capybara.session_name = :first
    visit '/user'
    assert has_css? '.alert-error'
  end

end
