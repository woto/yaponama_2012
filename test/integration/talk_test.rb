# encoding: utf-8
#
require 'test_helper'

class TalkTest < ActionDispatch::IntegrationTest

  test 'Пишем гостем указываем новые контактные данные' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'email@example.com'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (123) 324-52-34')"
    fill_in 'talk[text]', with: 'Текст сообщения 982374982374'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 982374982374'
  end

  test 'Пишем гостем не заполняем ничего' do
    Capybara.reset!
    visit '/'
    click_button 'talk-submit'
    name = find_field('talk[somebody_attributes][profile_attributes][names_attributes][0][name]').find(:xpath,".//..")
    sleep 1
    assert_equal 'has-error form-group', name['class']
    assert has_text? "пожалуйста укажите номер мобильного телефона и/или email"
    talk = find_field('talk[text]').find(:xpath,".//..")
    sleep 1
    assert_equal "has-error form-group", talk['class']
  end

  test 'Пишем гостем, указываем только email' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'email@example.com'
    fill_in 'talk[text]', with: 'Текст сообщения 823749842342349873402'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 823749842342349873402'
  end

  test 'Пишем гостем, указываем только phone' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (123) 324-52-34')"
    fill_in 'talk[text]', with: 'Текст сообщения 2938423443'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2938423443'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email).' do
    Capybara.reset!
    page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
    visit '/'
    fill_in 'talk[text]', with: 'Текст сообщения 234898723094875234234641'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 234898723094875234234641'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone)' do
    #flunk 'aaa'
    Capybara.reset!
    #page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email). И меняем их на свободные' do
    Capybara.reset!
    page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'some_new_email_34234593@example.com'
    fill_in 'talk[text]', with: 'Текст сообщения 82348943289234'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 82348943289234'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone). И меняем их на свободные' do
    Capybara.reset!
    #page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email). И меняем их на занятые' do
    Capybara.reset!
    page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'mark@example.com'
    fill_in 'talk[text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    email = find_field('talk[somebody_attributes][profile_attributes][emails_attributes][0][value]').find(:xpath,".//..")
    sleep 1
    assert_equal 'has-error form-group', email['class']
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone). И меняем их на занятые' do
    Capybara.reset!
    #page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
  end

  test 'Пишем зарегистрированным пользователем' do
    Capybara.reset!
    auth('+7 (123) 123-12-31', '1231231231')
    visit '/'
    fill_in 'talk[text]', with: 'Текст сообщения 2349823457983475'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349823457983475'
  end

  test 'Отправляем сообщение в одном окне, и в течении некоторого времени в другом окне мы так же видим это сообщение' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    auth('+7 (444) 444-44-44', '4444444444')

    Capybara.session_name = :second
    visit '/'
    auth('+7 (444) 444-44-44', '4444444444')

    Capybara.session_name = :first
    fill_in 'talk[text]', with: 'Текст сообщения 2349823457983475'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349823457983475'

    Capybara.session_name = :second
    assert has_text?('Текст сообщения 2349823457983475', wait: 10)

  end

  test 'После отправки сообщения анонимным пользователем у пользователя должен появиться профиль' do
    skip
  end



end
