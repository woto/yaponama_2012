# encoding: utf-8

require 'test_helper'

class NotifySoundTest < ActionDispatch::IntegrationTest
  test 'Если у пользователя включена пимпочка звукового оповещения при получении нового сообщения, то должен проиграться звук.' do

    Capybara.reset!
    SiteConfig.class_variable_set(:@@cache, nil)

    visit '/'
    
    pid = Process.spawn({"RAILS_ENV" => Rails.env}, "coffee #{Rails.root}/realtime/realtime.coffee")

    # Detach the spawned process
    Process.detach pid

    # Ждем пока иницилизируется node приложение
    # TODO если проблема действительно во времени, то позже переделаю на обработку сигнала, чтобы
    # не ждать слишком долго, но и быть уверенным, что приложение инициализировалось
    sleep 5

    Capybara.session_name = :first
    auth('+7 (111) 111-11-11', '1111111111')
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    find('#talk-button-show').click
    sleep 1
    save_screenshot('1.png', full: true)

    Capybara.session_name = :second
    auth('+7 (444) 444-44-44', '4444444444')
    assert has_css? ".alert-success", text: "Вы успешно вошли."

    find('#talk-button-show').click
    sleep 1
    save_screenshot('2.png', full: true)

    Process.kill "HUP", pid
  end
end
