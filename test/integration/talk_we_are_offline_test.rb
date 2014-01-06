# encoding: utf-8
#
require 'test_helper'

class TalkWeAreOfflineTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Запускаем node. Открываем главную страницу и открываем чат' do
    #1
    node do

      #2
      visit '/'
      click_link 'talk-button-show-inside'
      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'note что хотя бы один менеджер онлайн должен быть скрыт'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'


    end

  end

  test 'Делаем все то же самое только после захода на главную страницу мы кликаем по ссылке, чтобы в тесте задействовался turbolinks' do
    #1
    node do

      #2
      visit '/'
      click_link 'KIA'
      click_link 'talk-button-show-inside'
      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'note что хотя бы один менеджер онлайн должен быть скрыт'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

    end

  end

  test 'Заходим на главную открываем чат. Запускаем node' do
    #1
    visit '/'
    click_link 'talk-button-show-inside'

    # 2
    node do

      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'note что хотя бы один менеджер онлайн должен быть скрыт'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

    end

  end

  test 'Все то же самое, только задействовываем turbolinks' do
    #1
    visit '/'
    click_link 'KIA'
    click_link 'talk-button-show-inside'

    # 2
    node do

      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'note что хотя бы один менеджер онлайн должен быть скрыт'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

    end

  end

  test 'Заходим на сайт, когда менеджеров нет, запускаем node, а потом менеджер заходит' do
    # 1
    Capybara.session_name = :first
    visit '/'
    click_link 'talk-button-show-inside'

    has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
    has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
    has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

    # 2
    node do
      Capybara.session_name = :second
      auth('+7 (999) 999-99-99', '9999999999')

    end

    Capybara.session_name = :first
    assert has_css? '#we-are-online-note', 'мы должны увидеть что хотя бы один менеджер онлайн'

    assert has_no_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
    assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
    assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'
  end
 
  test 'То же самое, только с turbolinks' do
    # 1
    Capybara.session_name = :first
    visit '/'
    click_link 'KIA'
    click_link 'talk-button-show-inside'

    has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
    has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
    has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'


    # 2
    node do
      Capybara.session_name = :second
      auth('+7 (999) 999-99-99', '9999999999')
    end

    Capybara.session_name = :first
    assert has_css? '#we-are-online-note', 'мы должны увидеть что хотя бы один менеджер онлайн'

    assert has_no_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
    assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
    assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'
  end

  test 'Заходим на сайт, когда менеджер уже онлайн, запускаем node, а потом менеджер выходит' do

    # Заходим менеджером на сайт
    Capybara.session_name = :first
    auth('+7 (999) 999-99-99', '9999999999')

    # Запускаем node
    node do

      # Заходим гостем на главную
      Capybara.session_name = :second
      visit '/'

      # и открываем чат
      click_link 'talk-button-show-inside'
      assert has_css? '#we-are-online-note', 'мы должны увидеть что хотя бы один менеджер онлайн'

      assert has_no_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'
      
      # Выходим менеджером
      Capybara.session_name = :first
      page.driver.reset!

      # Под гостем
      Capybara.session_name = :second
      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'мы не должны увидеть что хотя бы один менеджер онлайн'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

    end

  end

  test 'Запускаем node. Заходим на сайт и заходим менеджером' do

    # 1
    node do
      Capybara.session_name = :first

      #2
      visit '/'
      click_link 'talk-button-show-inside'
      assert has_css? '#we-are-offline-note', 'мы должны увидеть сообщение о том, что все менеджеры оффлайн'
      assert has_no_css? '#we-are-online-note', 'мы не должны увидеть что хотя бы один менеджер онлайн'

      has_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      has_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'

      Capybara.session_name = :second
      auth('+7 (999) 999-99-99', '9999999999')

      Capybara.session_name = :first
      assert has_css? '#we-are-online-note', 'мы должны увидеть что хотя бы один менеджер онлайн'
      assert has_no_css? '#we-are-offline-note', 'мы не должны видеть сообщение, что менеджеры оффлайн'

      assert has_no_field? 'talk_somebody_attributes_profiles_attributes_0_names_attributes_0_name'
      assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_emails_attributes_0_value'
      assert has_no_field? '#talk_somebody_attributes_profiles_attributes_0_phones_attributes_0_value'
    end

  end

end
