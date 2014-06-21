# encoding: utf-8
#
require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase

  test 'Контроллер должен отдавать страницы только пользователям с ролью guest' do
    skip
  end

  test 'Проверка наличия поля для ввода номера мобильного телефона при запросе восстановления пароля через мобильный телефон' do
    get :contacts, password_reset: { with: 'phone' }
    assert_select "input[name='password_reset[value]']", true
  end

  test 'Проверка наличия поля для ввода e-mail при запросе восстановления пароля через e-mail' do
    get :contacts, password_reset: { with: 'email' }
    assert_select "input[name='password_reset[value]']", true
  end

  test 'Номер мобильного телефона не указан' do
    post :contacts, password_reset: { with: 'phone', value: '' }
    assert_equal ['не может быть пустым'], assigns(:password_reset).errors[:value]
  end

  test 'Номер мобильного телефона заполнен в неправильном формате' do
    post :contacts, password_reset: { with: 'phone', value: '123' }
    assert_equal ['имеет неверное значение'], assigns(:password_reset).errors[:value]
  end

  test 'Номер телефона указан в правильном формате. Является подтвержденным. Не является мобильным' do
    post :contacts, password_reset: { value: "+7 (666) 666-66-66", with: "phone" }
    assert_equal ['Мы не смогли найти среди зарегистрированных покупателей указанные вами данные, проверьте ввод и попробуйте еще раз, или свяжитесь с службой поддержки.'], assigns(:password_reset).errors[:base]
  end

  test 'Номер телефона указан в правильном формате. Является мобильным. Не является подтвержденным' do
    post :contacts, password_reset: { value: "+7 (111) 111-11-11", with: "phone" }
    assert_equal ['Мы не смогли найти среди зарегистрированных покупателей указанные вами данные, проверьте ввод и попробуйте еще раз, или свяжитесь с службой поддержки.'], assigns(:password_reset).errors[:base]
  end

  test 'Номер мобильного телефона заполнен правильно. Является мобильным. Является подтвержденным. ' do
    
    old_password_reset_token = somebodies(:otto).password_reset_token
    post :contacts, password_reset: { value: "+7 (555) 555-55-55", with: "phone" }
    new_password_reset_token = somebodies(:otto).reload.password_reset_token

    # password_reset_token должен измениться
    refute_equal old_password_reset_token, new_password_reset_token

    # Пользователь должен быть редирекнут на страницу ввода pin кода
    assert_redirected_to pin_password_reset_path(
      'password_reset' => {
        'value' => '+7 (555) 555-55-55',
        'with' => 'phone'
      }
    )

    # Уведомление о том, что мы отправили SMS.
    assert_equal "Мы отправили вам SMS с PIN кодом. Введите его в поле, расположенное ниже, либо перейдите по ссылке если ваш телефон поддерживает эту функцию. Сделайте повторный запрос PIN кода, если вы вдруг не получили SMS.", flash[:info]

    #  TODO время генерации токена и сброс количества попыток

    delivery = ActionMailer::Base.deliveries.last

    # Адресат SMS
    assert_equal [SiteConfig.avisosms_email_address], delivery.to

    # Заголовок SMS
    assert_equal "+75555555555", delivery.subject

    # pin код в SMS
    assert_match Regexp.new("PIN: " + new_password_reset_token), delivery.body.encoded

    # ссылка в SMS
    assert_match(
      Regexp.new(
        Regexp.escape(
          password_password_reset_path(
            'password_reset' => {
             'value' => '+7 (555) 555-55-55',
             'with' => 'phone',
             'pin' => new_password_reset_token
            }
          )
        )
      ), delivery.body.encoded
    )

  end

  test 'E-mail не указан' do
    post :contacts, password_reset: { with: 'email', value: '' }
    assert_equal ["не может быть пустым"], assigns(:password_reset).errors[:value]
  end

  test 'E-mail заполнен в неправильном формате' do
    post :contacts, password_reset: { with: 'email', value: '123@123' }
    assert_equal ["имеет неверное значение"], assigns(:password_reset).errors[:value]
  end

  test 'E-mail заполнен правильно. Является не подтвержденным.' do
    post :contacts, password_reset: { value: "foo@example.com", with: "email" }
    assert_equal ['Мы не смогли найти среди зарегистрированных покупателей указанные вами данные, проверьте ввод и попробуйте еще раз, или свяжитесь с службой поддержки.'], assigns(:password_reset).errors[:base]
  end

  test 'E-mail заполнен правильно. Является подтвержденным.' do

    old_password_reset_token = somebodies(:otto).password_reset_token
    post :contacts, password_reset: { value: "fake@example.com", with: "email" }
    new_password_reset_token = somebodies(:otto).reload.password_reset_token
    #
    # password_reset_token должен измениться
    refute_equal old_password_reset_token, new_password_reset_token

    # Пользователь должен быть редирекнут на страницу ввода pin кода
    assert_redirected_to pin_password_reset_path(
      'password_reset' => {
        'value' => 'fake@example.com',
        'with' => 'email'
      }
    )

    # Уведомление о том, что мы отправили e-mail.
    assert_equal "Мы отправили вам электронное письмо с PIN кодом. Введите его в поле, расположенное ниже, либо перейдите по ссылке в письме. Не забудьте проверить папку спам, если долго не получаете письмо.", flash[:info]

    #  TODO время генерации токена и сброс количества попыток

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert_equal ["fake@example.com"], delivery.to

    # Заголовок письма
    assert_equal "Восстановление пароля", delivery.subject

    # pin код в письме
    assert_match Regexp.new("PIN: " + new_password_reset_token), delivery.body.encoded

    # ссылка в письме
    assert_match(
      Regexp.new(
        Regexp.escape(
          ERB::Util.html_escape(
            password_password_reset_path(
              'password_reset' => {
                'value' => 'fake@example.com',
                'with' => 'email',
                'pin' => new_password_reset_token
              }
            )
          )
        )
      ), delivery.body.encoded
    )

  end

  test 'Мы не можем изменить пароль (отправив запрос к done) указав неверный PIN код' do
    post :done, {
      'password_reset' => {
        'value' => '+7 (777) 777-77-77',
        'with' => 'phone',
        'pin' => 'zzz',
        'password' => '123456',
        'password_confirmation' => '123456'
      }
    }
    assert_equal [[:pin, "Указан неверный PIN код."]], assigns(:password_reset).errors.entries
  end

  test 'Мы не можем изменить пароль (отправив запрос к done) если прошло более 2-х часов' do
    post :done, {
      'password_reset' => {
        'value' => '+7 (777) 777-77-77',
        'with' => 'phone',
        'pin' => '1234',
        'password' => '123456',
        'password_confirmation' => '123456'
      }
    }
    assert_equal [[:base, "В целях безопасности ваша инструкция по восстановлению пароля была признана устаревшей, пожалуйста запросите новую."]], assigns(:password_reset).errors.entries
  end

  test 'Мы не можем изменить пароль (отправив запрос к done) если пароль и подтверждение не удовлетворяют нашим требованиям' do
    post :done, {
      'password_reset' => {
        'value' => '+7 (777) 777-77-77',
        'with' => 'phone',
        'pin' => '55555',
      }
    }
    assert_equal ["не может быть пустым", "недостаточной длины (не может быть меньше 6 символа)"], assigns(:password_reset).errors[:password]
    assert_equal ["не может быть пустым"], assigns(:password_reset).errors[:password_confirmation]
  end

  test 'Дописать и протестировать накрутки, проникновения и т.д.' do
    skip
    # TODO Тестирование pin и password не принципиально, т.к. ничего компрометирующего там нет.
    # Везде где pin_required будет увеличиваться счетчик ввода попыток.
    # когда появятся счетчики (напр. попыток неверного ввода, тогда можно будет вернуться)
    # А так же не обрабатывается (не показывается причина) в случае если pin код устарел и пользователь
    # перешел по ссылке. В случае ручного ввода - обрабатывается.
  end

end
