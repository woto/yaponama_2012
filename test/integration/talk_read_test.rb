# encoding: utf-8
#
require 'test_helper'

class TalkReadTest < ActionDispatch::IntegrationTest

  test 'Отправив сообщение покупателем в одном окне мы не должны поменять его статус прочитанности в другом' do
    Capybara.reset!

    Capybara.session_name = :first
    auth('+7 (444) 444-44-44', '4444444444')
    fill_in 'talk[text]', with: 'Текст сообщения 2349843587234908'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 2349843587234908'

    Capybara.session_name = :second
    auth('+7 (444) 444-44-44', '4444444444')
    assert has_text? 'Текст сообщения 2349843587234908'
    talk = Talk.where(text: 'Текст сообщения 2349843587234908').first
    assert_equal false, talk.read
  end

  test 'Отправив сообщение продавцом в одном окне мы не должны поменять его статус прочитанности в другом ни этим же продавцом, ни другим' do
    Capybara.reset!

    Capybara.session_name = :first
    auth('+7 (111) 111-11-11', '1111111111')
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 23489232134438294505'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 23489232134438294505'

    Capybara.session_name = :second
    auth('+7 (111) 111-11-11', '1111111111')
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    assert has_text? 'Текст сообщения 23489232134438294505'
    talk = Talk.where(text: 'Текст сообщения 23489232134438294505').first
    assert_equal false, talk.read

    Capybara.session_name = :third
    auth('+7 (000) 000-00-00', '0000000000')
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
    auth('+7 (111) 111-11-11', '1111111111')
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 423748924375089273146438'
    click_button 'talk-submit'
    assert has_text? 'Текст сообщения 423748924375089273146438'

    Capybara.session_name = :second
    auth('+7 (555) 555-55-55', '5555555555')
    assert has_text?('Текст сообщения 423748924375089273146438', wait: 10)

    talk = Talk.where(text: 'Текст сообщения 423748924375089273146438').first
    assert_equal true, talk.read
  end

  test 'Смена статуса прочитанности от проадвца покупателю (покупатель был в онлайне когда сообщение пришло)' do
    Capybara.reset!

    Capybara.session_name = :first
    auth('+7 (555) 555-55-55', '5555555555')

    Capybara.session_name = :second
    auth('+7 (111) 111-11-11', '1111111111')
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
