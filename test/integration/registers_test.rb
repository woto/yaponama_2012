# encoding: utf-8

require 'test_helper'

class RegistersTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test "При успешной регистрации с помощью e-mail должен произойти редирект в личный кабинет, должно отправиться письмо на этот адрес и должна присутствовать ссылка для подтверждения вверху страницы" do
    ActionMailer::Base.deliveries.clear

    visit '/register/edit?with=email'
    fill_in 'user[profiles_attributes][0][names_attributes][0][name]', with: 'Иван'
    fill_in 'user[profiles_attributes][0][emails_attributes][0][value]', with: 'ivan@example.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Зарегистрироваться'

    # Личный кабинет
    assert current_url.end_with?('/user')

    # Письмо было отправлено на этот адрес
    assert_equal 1, ActionMailer::Base.deliveries.size

  end

  test 'При успешной регистрации с помощью мобильного телефона Россия должен произойти редирект в личный кабинет, должно отправиться sms и должна присутствоваться ссылка для подтверждения номера телефона' do
    ActionMailer::Base.deliveries.clear

    visit '/register/edit?with=phone'

    fill_in 'user[profiles_attributes][0][names_attributes][0][name]', with: 'Иван'
    fill_in 'user[profiles_attributes][0][phones_attributes][0][value]', with: '+7 (746) 394-31-94'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Зарегистрироваться'

    # Личный кабинет
    assert current_url.end_with?('/user')

    # sms была отправлена на этот адрес
    assert_equal 1, ActionMailer::Base.deliveries.size

  end

end
