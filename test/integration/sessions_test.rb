require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest

  test 'Если стоит галка запомнить меня' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111', true)
    assert get_me_the_cookie('auth_token')[:expires]
  end

  test 'Если не стоит галка запомнить меня' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111', false)
    refute get_me_the_cookie('auth_token')[:expires]
  end

  test 'Мы должны войти если номер мобильного телефона и пароль верны, под селлером попадаем в админку.' do
    Capybara.reset!
    visit '/login/phone'
    fill_phone '#session_value', '+7 (111) 111-11-11'
    fill_in 'session[password]', with: '1111111111'
    click_button 'Войти'
    assert has_text? "Вы успешно вошли"
    assert current_url.end_with?('/admin')
  end

  test 'Мы должны войти если номер мобильного телефона и пароль верны, под байером попадаем в личный кабинет.' do
    Capybara.reset!
    visit '/login/phone'
    fill_phone '#session_value', '+7 (123) 123-12-31'
    fill_in 'session[password]', with: '1231231231'
    click_button 'Войти'
    assert has_text? "Вы успешно вошли"
    assert current_url.end_with?('/user')
  end

  test 'Мы не можем войти если такой номер телефона числится, но пароль неверен' do
    Capybara.reset!
    visit '/login/phone'
    fill_phone '#session_value', '+7 (111) 111-11-11'
    fill_in 'session[password]', with: '1111111112'
    click_button 'Войти'
    assert page.has_css? ".alert-danger", text: "Пара телефон и пароль не найдены"
  end

  test 'Мы должны войти если email адрес и пароль верны' do
    Capybara.reset!
    visit '/login/email'
    fill_in 'session[value]', with: 'foo@example.com'
    fill_in 'session[password]', with: '1111111111'
    click_button 'Войти'
    assert has_text? "Вы успешно вошли"
    assert current_url.end_with?('/admin')
  end

  test 'Мы не можем войти если такой email числится, но пароль неверен' do
    Capybara.reset!
    visit '/login/email'
    fill_in 'session[value]', with: 'foo@example.com'
    fill_in 'session[password]', with: '2111111111'
    click_button 'Войти'
    assert page.has_css? ".alert-danger", text: "Пара e-mail и пароль не найдены"
  end

end
