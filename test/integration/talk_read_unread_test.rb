# encoding: utf-8
#
require 'test_helper'

class TalkReadUnreadTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Проверяем целостность сообщений, т.к. возможно нарушение в связи с природой fixtures' do
    assert_equal somebodies(:petr).talks.count, somebodies(:petr).total_talks
    assert_equal somebodies(:petr).talks.where(read: false).count, somebodies(:petr).unread_talks
    assert_equal somebodies(:mark).talks.count, somebodies(:mark).total_talks
    assert_equal somebodies(:mark).talks.where(read: false).count, somebodies(:mark).unread_talks
    assert_equal somebodies(:sidor).talks.count, somebodies(:sidor).total_talks
    assert_equal somebodies(:sidor).talks.where(read: false).count, somebodies(:sidor).unread_talks
  end

  test "Прочитанное сообщение должно быть отмечено чекбоксом и .active стилем bootstrap'a" do
    auth('+7 (444) 444-44-44', '4444444444')

    click_link 'talk-button-show-inside'

    assert find('#talk_read_11', visible: false).checked?


    # TODO Из-за того, что не знаю как сделать так чтобы проверить текущий элемент на селектор(ы)
    # вынужден получать еще родительский на уровень вверх проверяемого
    assert find('#talk_read_11', visible: false).first(:xpath,".//..").first(:xpath,".//..").has_css?('label.active')
  end

  test 'Если мы меняем статус прочитанности сообщения, то о новом статусе должны узнать все заинтересованные лица' do

    node do

      mark = somebodies(:mark)

      # Заходим Сидором в область Марка и проверяем, что сообщение не прочитано
      Capybara.session_name = :first
      auth '+7 (000) 000-00-00', '0000000000'
      visit "/admin/users/#{mark.id}"
      click_link 'talk-button-show-inside'
      refute find('#talk_read_7', visible: false).checked?

      # Заходим Марком и проверям, что сообщение не прочитано
      Capybara.session_name = :second
      auth '+7 (444) 444-44-44', '4444444444'
      click_link 'talk-button-show-inside'
      refute find('#talk_read_7', visible: false).checked?

      Capybara.session_name = :first
      # Помечаем Сидором, что сообщение прочитано
      find('#talk_read_7', visible: false).first(:xpath,".//..").click

      # Проверяем чекбокс, чтобы стал checked
      assert find('#talk_read_7', visible: false).checked?

      Capybara.session_name = :second
      # Проверяем Марком, что сообщение прочитано
      sleep 1 # На самом деле sleep не нужен, это Капибаровская прихоть
      assert find('#talk_read_7', visible: false).checked?

    end

  end

  test 'Если получатель сообщения способен менять статус прочитанности сообщения (менеджер или админ), то сообщение должно быть read == false' do
    skip
  end

  test 'И наоборот, если получатель не способен менять статус прочитанности, то сообщение сразу read == true' do
    skip
  end


end
