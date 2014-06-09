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
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
  end

  test 'Пишем гостем не заполняем ничего' do
    Capybara.reset!
    visit '/'
    click_button 'talk-submit'
    name = find_field('talk[somebody_attributes][profile_attributes][names_attributes][0][name]').find(:xpath,".//..")
    sleep 1
    assert_equal 'has-error form-group', name['class']
    assert has_text? "пожалуйста укажите номер мобильного телефона и/или email"
    talk = find_field('talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]').find(:xpath,".//..")
    sleep 1
    assert_equal "has-error form-group", talk['class']
  end

  test 'Пишем гостем, указываем только email' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'email@example.com'
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
  end

  test 'Пишем гостем, указываем только phone' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (123) 324-52-34')"
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email).' do
    Capybara.reset!
    page.driver.set_cookie "auth_token", "8e9beU3E20YWHmF1RBSwFa"
    visit '/'
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
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
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
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
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
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
    fill_in 'talk[talkable_attributes][chat_parts_attributes][0][chat_partable_attributes][text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? 'Чат норм'
  end

end
