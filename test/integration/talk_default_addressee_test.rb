# encoding: utf-8
#
require 'test_helper'

class TalkDefaultAddresseeTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Если мы отправляем сообщение селлеру, то он становится адресатом по-умолчанию (И в реалтайме, но только не в области другого пользователя)' do
    first_admin = somebodies(:first_admin)
    first_user = somebodies(:first_user)
    anton = somebodies(:anton)

    node do
      # Заходим first_user, убеждаемся, что получателя по-умолчанию нет
      Capybara.session_name = :first
      auth('+7 (123) 123-12-31', '1231231231')
      click_link 'talk-button-show-inside'
      assert has_field? 'talk_addressee_id', with: '', visible: false
      assert_equal nil, first_user.reload.default_addressee

      # Заходим first_admin в область anton, убеждаемся что он получатель
      Capybara.session_name = :second
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{anton.id}"
      click_link 'talk-button-show-inside'
      assert has_field? 'talk_addressee_id', with: anton.id.to_s, visible: false

      # Заходим параллельно first_user'ом и отправляем сообщение first_admin'у
      Capybara.session_name = :third
      auth('+7 (123) 123-12-31', '1231231231')
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{first_admin.id}"
      fill_talk 'Проверяем выставление дефолтного селлера'
      click_button 'talk-submit'

      # Убеждаемся, что смена дефолтного селлера никак не повлияла на изменение 
      # default_addressee в области третьего пользователя - anton'а
      Capybara.session_name = :second
      assert has_field? 'talk_addressee_id', with: anton.id.to_s, visible: false
      
      # Убеждаемся, что в другом окне first_user дефолтный селлер выставился, 
      # как в онлайне, так и в базе
      Capybara.session_name = :third
      assert has_field? 'talk_addressee_id', with: first_admin.id.to_s, visible: false
      sleep 3
      assert_equal first_admin, first_user.reload.default_addressee

    end

  end

  test 'Если у нас выставлен адресат по-умолчанию, но мы отправляем сообщение всем, то адресат по-умолчанию сбрасывается (Как в реалтайм, так и в базе)' do
    first_admin = somebodies(:first_admin)
    otto = somebodies(:otto)

    node do

      Capybara.session_name = :first
      auth('+7 (555) 555-55-55', '5555555555')
      click_link 'talk-button-show-inside'

      Capybara.session_name = :second
      auth('+7 (555) 555-55-55', '5555555555')
      assert_equal first_admin, otto.reload.default_addressee
      click_link 'talk-button-show-inside'
      click_link 'i-dont-want-to-choose-seller'
      fill_talk 'Проверяем сброс дефолтного селлера'
      click_button 'talk-submit'

      sleep 3
      assert_equal nil, otto.reload.default_addressee

      Capybara.session_name = :first
      sleep 3
      assert has_field? 'talk_addressee_id', with: '', visible: false

    end

  end

  test 'Если нам присылает сообщение селлер, то дефолтный адресат становится он (Но только если мы не находимся в области третьего пользователя)' do

    first_admin = somebodies(:first_admin)
    sidor = somebodies(:sidor)
    ivan = somebodies(:ivan)

    assert_equal nil, ivan.reload.default_addressee

    node do
      Capybara.session_name = :first
      auth('+7 (999) 999-99-99', '9999999999')
      visit '/user'
      click_link 'talk-button-show-inside'

      Capybara.session_name = :second
      auth('+7 (999) 999-99-99', '9999999999')
      anton = somebodies(:anton)
      visit "/admin/users/#{anton.id}"
      click_link 'talk-button-show-inside'

      Capybara.session_name = :third
      auth('+7 (000) 000-00-00', '0000000000')
      visit '/user'
      click_link 'talk-button-show-inside'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{ivan.id}"
      fill_talk 'Я отправляю сообщение и становлюсь дефолтным менеджером у получателя за исключением предусмотренного случая'
      click_button 'talk-submit'

      # (У ivan sidor стал дефолтным менеджером) И в публичной зоне в реалтайм изменился
      Capybara.session_name = :first
      assert has_field? 'talk_addressee_id', with: sidor.id.to_s, visible: false

      # А вот в закрытой зоне (в области пользователя anton) остался неизменным,
      # т.е. по-прежнему anton.
      Capybara.session_name = :second
      assert has_field? 'talk_addressee_id', with: anton.id.to_s, visible: false

      sleep 3
      # У ivan sidor стал дефолтным менеджером
      assert_equal sidor, ivan.reload.default_addressee

    end
  end

  test 'Если нам присылает сообщение байер, то это никак не влияет на дефолтного адресата' do

    ivan = somebodies(:ivan)
    fry = somebodies(:fry)

    assert_equal nil, ivan.reload.default_addressee
    assert_equal nil, fry.reload.default_addressee

    node do
      # Заходим селлером (ivan) в публичную зону
      Capybara.session_name = :first
      auth('+7 (999) 999-99-99', '9999999999')
      visit '/user'
      click_link 'talk-button-show-inside'

      # Заходим селлером (ivan) в админке, в свою зону
      Capybara.session_name = :second
      auth('+7 (999) 999-99-99', '9999999999')
      visit "/admin/users/#{ivan.id}"
      click_link 'talk-button-show-inside'

      # Отправляем байером (fry) сообщение селлеру (ivan)
      Capybara.session_name = :third
      auth('+7 (321) 321-32-13', '3213213213')
      click_link 'talk-button-show-inside'
      fill_talk 'Отправляем байером (fry) сообщение селлеру (ivan)'
      click_link 'i-want-to-choose-seller'
      click_link "select-addressee-#{ivan.id}"
      click_button 'talk-submit'

      # Далее убеждаемся, что нигде байер (fry) не стал дефолтным адресатом
      Capybara.session_name = :first
      assert has_field? 'talk_addressee_id', with: '', visible: false

      Capybara.session_name = :second
      assert has_field? 'talk_addressee_id', with: ivan.id.to_s, visible: false

      assert_equal nil, ivan.reload.default_addressee

    end

  end

end
