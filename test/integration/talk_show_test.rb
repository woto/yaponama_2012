# encoding: utf-8
#
require 'test_helper'

class TalkShowTest < ActionDispatch::IntegrationTest

  test 'Если talk отсутствует, то чат не отображается, кнопка службы поддержки отображается' do
    Capybara.reset!
    visit '/'

    assert has_no_css? '#talk-window'
    assert has_css? '#talk-show'
  end

  test 'Если talk 0, то чат не отображается, кнопка службы поддержки отобаражется' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "0"
    visit '/'

    assert has_no_css? '#talk-window'
    assert has_css? '#talk-show'
  end

  test 'Если talk 1, то чат отображается, кнопка службы поддержки не отображается' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'

    assert has_css? '#talk-window'
    assert has_no_css? '#talk-show'
  end

  test 'Скрываем чат нажав на крестик' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "1"
    visit '/'

    click_link 'talk-hide'
    assert has_no_css? '#talk-window'
    assert has_css? '#talk-show'
  end

  test 'Показываем чат нажав на "Службу поддержки"' do
    Capybara.reset!
    visit '/'
    create_cookie "talk", "0"
    visit '/'

    click_link 'talk-show'
    assert has_no_css? '#talk-show'
    assert has_css? '#talk-window'
  end

  test 'Если у нас чат скрыт и пришло сообщение, то должен появиться чат' do
    Capybara.reset!
    otto = somebodies(:otto)

    Capybara.session_name = :first
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", otto.reload.auth_token
    visit '/'
    ## TODO Если таким способом записать cookie,
    ## то не будет возможности его изменить?!
    ##page.driver.set_cookie "talk", "0"
    click_link 'talk-hide'
    assert has_no_css? '#talk-window'

    Capybara.session_name = :second
    visit '/'
    create_cookie "talk", "1"
    create_cookie "auth_token", "PaV6t6OZxzRIWbl0nM9NGQ"
    visit '/'
    visit "/admin/users/#{otto.id}"
    fill_in 'talk[text]', with: 'Текст сообщения 2341092378450193485712347654323474'
    click_button 'talk-submit'

    Capybara.session_name = :first
    assert has_css?('#talk-window', wait: 10)
  end

end
