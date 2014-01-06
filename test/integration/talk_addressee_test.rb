# encoding: utf-8
#
require 'test_helper'

class TalkAddresseeTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Если default_addressee есть, то он выставляется в talk_addressee_id (еще в самом контроллере)' do

    node do

      first_admin = somebodies(:first_admin)
      otto = somebodies(:otto)

      assert_equal first_admin, otto.reload.default_addressee

      auth('+7 (555) 555-55-55', '5555555555')
      click_link 'talk-button-show-inside'

      # talk_addressee_id должен был взяться из default_addressee
      assert has_field? 'talk_addressee_id', with: "#{first_admin.id}", visible: false

      # отображен должен быть только этот менеджер
      assert has_css? "#select-addressee-#{first_admin.id}"

      #  должна быть доступна ссылка i-dont-want-to-choose-seller
      assert has_link? 'i-dont-want-to-choose-seller'

    end

  end

  test 'Если default_addressee отстутствует, то talk_addressee_id должен быть пустым' do

    node do

      first_user = somebodies(:first_user)
      first_admin = somebodies(:first_admin)

      assert_equal nil, first_user.reload.default_addressee

      auth('+7 (123) 123-12-31', '1231231231')
      click_link 'talk-button-show-inside'

      # talk_addressee_id должен быть пустым
      assert has_field? 'talk_addressee_id', with: '', visible: false

      #  должна быть доступна ссылка i-want-to-choose-seller
      assert has_link? 'i-want-to-choose-seller'

    end

  end

  test 'Проверяем заполнение talk_address_id при выборе селлера из списка' do
    first_admin = somebodies(:first_admin)

    node do

      visit '/'
      click_link 'talk-button-show-inside'
      # Отображаем список менеджеров
      click_link 'i-want-to-choose-seller'
      #выбираем получателя
      click_link "select-addressee-#{first_admin.id}"
      sleep 1

      # Проверяем что talk_addressee_id заполнился
      assert has_field? 'talk_addressee_id', with: "#{first_admin.id}", visible: false

      # Проверяем что теперь отображается только один - выбранный менеджер
      assert has_css? '.concrete-seller', count: 1
      assert has_css? "#select-addressee-#{first_admin.id}"

      #кликаем на "не указывать получателя"
      click_link 'i-dont-want-to-choose-seller'

      # Проверяем что talk-addressee_id очистился
      assert has_field? 'talk_addressee_id', with: '', visible: false

    end

  end

  test 'Если мы пишем сообщение селлером в админке, то addresse_id должен быть пользователем в чьей области мы находимся, а не default_addressee' do
    first_admin = somebodies(:first_admin)
    ivan = somebodies(:ivan)
    otto = somebodies(:otto)

    assert_equal ivan, first_admin.default_addressee

    node do
      auth('+7 (111) 111-11-11', '1111111111')
      visit "/admin/users/#{otto.id}"
      click_link 'talk-button-show-inside'

      # Проверяем что talk_addressee_id заполнился пользователем, а не default_addressee
      assert has_field? 'talk_addressee_id', with: "#{otto.id}", visible: false
    end

  end

end
