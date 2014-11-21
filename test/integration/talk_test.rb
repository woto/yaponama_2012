# encoding: utf-8
#
require 'test_helper'

class TalkTest < ActionDispatch::IntegrationTest

  test 'Пишем гостем указываем новые контактные данные' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'email@example.com'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (123) 324-52-34')"
    fill_in 'talk[text]', with: 'Текст сообщения 982374982374'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 982374982374'
    assert has_field? 'talk_somebody_attributes_profile_attributes_names_attributes_0_name', with: 'Имя'
    assert has_field? 'talk_somebody_attributes_profile_attributes_phones_attributes_0_value', with: '+7 (123) 324-52-34'
    assert has_field? 'talk_somebody_attributes_profile_attributes_emails_attributes_0_value', with: 'email@example.com'
    assert has_field? 'talk_text', with: ''
  end

  test 'Пишем гостем не заполняем ничего' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'
    click_button 'talk-submit'
    assert has_text? "укажите телефон и/или email"
    name = find_field('talk[somebody_attributes][profile_attributes][names_attributes][0][name]').find(:xpath,".//..")
    assert_equal 'has-error form-group', name['class']
    talk = find_field('talk[text]').find(:xpath,".//..")
    assert_equal "has-error form-group", talk['class']
  end

  test 'Пишем гостем, заполняем только имя и сообщение' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'

    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[text]', with: 'Текст сообщения 23844539023747432047'
    click_button 'talk-submit'
    assert has_text? "укажите телефон и/или email"
  end

  test 'Пишем гостем, указываем только email' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
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
    create_cookie "talk", "1"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (123) 324-52-34')"
    fill_in 'talk[text]', with: 'Текст сообщения 2938423443'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2938423443'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email).' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:guest_with_profile).auth_token
    visit '/'
    fill_in 'talk[text]', with: 'Текст сообщения 234898723094875234234641'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 234898723094875234234641'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone)' do
    #flunk 'aaa'
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:guest_with_profile).auth_token
    visit '/'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email). И меняем их на свободные' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:guest_with_profile4).auth_token
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'some_new_email_34234593@example.com'
    fill_in 'talk[text]', with: 'Текст сообщения 82348943289234'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 82348943289234'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone). И меняем их на свободные' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:guest_with_profile).auth_token
    visit '/'
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (email). И меняем их на занятые' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:guest_with_profile).auth_token
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'mark@example.com'
    fill_in 'talk[text]', with: 'Текст сообщения'
    click_button 'talk-submit'
    assert has_text? "Такой e-mail адрес уже занят."
    email = find_field('talk[somebody_attributes][profile_attributes][emails_attributes][0][value]').find(:xpath,".//..")
    assert_equal 'has-error form-group', email['class']
  end

  test 'Пишем гостем, у которого уже заполнены контактные данные (phone). И меняем их на занятые' do
    Capybara.reset!
    visit '/'
    create_cookie "auth_token", somebodies(:guest_with_profile).auth_token
    create_cookie "talk", "1"
    visit '/'
  end

  test 'Пишем зарегистрированным пользователем' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:first_user).auth_token
    visit '/'
    fill_in 'talk[text]', with: 'Текст сообщения 2349823457983475'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349823457983475'
  end

  test 'Отправляем сообщение в одном окне, и в течении некоторого времени в другом окне мы так же видим это сообщение' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:mark).auth_token
    visit '/'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:mark).auth_token
    visit '/'

    Capybara.session_name = :first
    fill_in 'talk[text]', with: 'Текст сообщения 2349823457983475'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349823457983475'

    Capybara.session_name = :second
    assert has_text?('Текст сообщения 2349823457983475', wait: 10)
  end

  test 'Если мы заполнили только телефон, то e-mail не должен добавиться в базу' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (193) 332-91-34')"
    fill_in 'talk[text]', with: 'Текст сообщения 2348923481273439'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2348923481273439'

    auth_token = get_me_the_cookie('auth_token')[:value]
    somebody = Somebody.find_by(auth_token: auth_token)
    assert_equal 0, somebody.profile.emails.count
  end


  test 'Если email содержит ошибки, то rejected телефон должен досоздаться' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Имя'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'email'
    fill_in 'talk[text]', with: 'Текст сообщения 23492347t4938234824572375'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 23492347t4938234824572375'
    assert has_field? 'talk[somebody_attributes][profile_attributes][phones_attributes][0][value]'
  end

  test 'После отправки сообщения анонимным пользователем у пользователя должен появиться профиль' do
    skip
  end

end
