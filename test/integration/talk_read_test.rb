# encoding: utf-8
#
require 'test_helper'

class TalkReadTest < ActionDispatch::IntegrationTest

  test 'Отправив сообщение покупателем в одном окне мы не должны поменять его статус прочитанности в другом' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:mark).auth_token
    visit '/'
    fill_in 'talk[text]', with: 'Текст сообщения 2349843587234908'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349843587234908'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:mark).auth_token
    visit '/'
    assert has_text? 'Текст сообщения 2349843587234908'
    talk = Talk.where(text: 'Текст сообщения 2349843587234908').first
    assert_equal false, talk.read
  end

  test 'Отправив сообщение продавцом в одном окне мы не должны поменять его статус прочитанности в другом ни этим же продавцом, ни другим' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:first_admin).auth_token
    visit '/'
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 23489232134438294505'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 23489232134438294505'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:first_admin).auth_token
    visit '/'
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    assert has_text? 'Текст сообщения 23489232134438294505'
    talk = Talk.where(text: 'Текст сообщения 23489232134438294505').first
    assert_equal false, talk.read

    Capybara.session_name = :third
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:sidor).auth_token
    visit '/'
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    assert has_text? 'Текст сообщения 23489232134438294505'
    talk = Talk.where(text: 'Текст сообщения 23489232134438294505').first
    assert_equal false, talk.read
  end

  test 'Смена статуса прочитанности от покупателя продавцу' do
    skip
  end

  test 'Смена статуса прочитанности от проадвца покупателю (покупатель зашел, а сообщение уже было написано)' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:first_admin).auth_token
    visit '/'
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 423748924375089273146438'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 423748924375089273146438'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:otto).auth_token
    visit '/'
    assert has_text?('Текст сообщения 423748924375089273146438', wait: 10)

    talk = Talk.where(text: 'Текст сообщения 423748924375089273146438').first
    assert_equal true, talk.read
  end

  test 'Смена статуса прочитанности от проадвца покупателю (покупатель был в онлайне когда сообщение пришло)' do
    Capybara.reset!

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:otto).auth_token
    visit '/'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", somebodies(:first_admin).auth_token
    visit '/'
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 129375238495712345432871234'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 129375238495712345432871234'

    Capybara.session_name = :first
    assert has_text?('Текст сообщения 129375238495712345432871234')

    talk = Talk.where(text: 'Текст сообщения 129375238495712345432871234').first
    assert_equal true, talk.read
  end

end
