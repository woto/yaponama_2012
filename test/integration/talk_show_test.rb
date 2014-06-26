# encoding: utf-8
#
require 'test_helper'

class TalkShowTest < ActionDispatch::IntegrationTest

  test 'Tckb talk отсутствует, то чат отображается, кнопка службы поддержки не отображается' do
    Capybara.reset!
    visit '/'
    assert has_css? '#talk-window'
    assert has_no_css? '#talk-show'
  end

  test 'Если talk 0, то чат не отображается, кнопка службы поддержки отобаражется' do
    Capybara.reset!
    page.driver.set_cookie "talk", "0"
    visit '/'

    assert has_no_css? '#talk-window'
    assert has_css? '#talk-show'
  end

  test 'Если talk 1, то чат отображается, кнопка службы поддержки не отображается' do
    Capybara.reset!
    page.driver.set_cookie "talk", "1"
    visit '/'

    assert has_css? '#talk-window'
    assert has_no_css? '#talk-show'
  end

  test 'Скрываем чат нажав на крестик' do
    Capybara.reset!
    page.driver.set_cookie "talk", "1"
    visit '/'

    click_link 'talk-hide'
    assert has_no_css? '#talk-window'
    assert has_css? '#talk-show'
  end

  test 'Показываем чат нажав на "Службу поддержки"' do
    Capybara.reset!
    page.driver.set_cookie "talk", "0"
    visit '/'

    click_link 'talk-show'
    sleep 3
    assert has_css? '#talk-window'
    assert has_no_css? '#talk-show'
  end

  test 'Если у нас чат скрыт и пришло сообщение, то должен появиться чат' do
    Capybara.reset!

    Capybara.session_name = :first
    auth('+7 (555) 555-55-55', '5555555555')
    # TODO Если таким способом записать cookie,
    # то не будет возможности его изменить?!
    #page.driver.set_cookie "talk", "0"
    click_link 'talk-hide'
    assert has_no_css? '#talk-window'

    Capybara.session_name = :second
    auth('+7 (111) 111-11-11', '1111111111')
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 2341092378450193485712347654323474'
    click_button 'talk-submit'

    Capybara.session_name = :first
    assert has_css?('#talk-window', wait: 10)
  end

end
