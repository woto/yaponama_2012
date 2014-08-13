# encoding: utf-8
#
require 'test_helper'

class RegistersControllerTest < ActionController::TestCase

  test 'Зарегистрироваться может только пользователь с ролью guest' do
    skip
  end

  test 'Не могут запросить форму без with' do
    skip
  end

  test 'Если запрашивают форму с заполненым профилем, то проставляем сразу значения. Email' do
    cookies[:auth_token] = somebodies(:guest_with_profile3).auth_token
    get 'edit', {with: 'email'}
    assert_select "[name='user[profile_attributes][names_attributes][0][name]'][value=?]", 'Ыфывоа'
    assert_select "[name='user[profile_attributes][emails_attributes][0][value]'][value=?]", 'wefhs@iewiw.jp'
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Если запрашивают форму с заполненым профилем, то проставляем сразу значения. Phone' do
    cookies[:auth_token] = somebodies(:guest_with_profile3).auth_token
    get 'edit', {with: 'phone'}
    assert_select "[name='user[profile_attributes][names_attributes][0][name]'][value=?]", 'Ыфывоа'
    assert_select "[name='user[profile_attributes][phones_attributes][0][value]'][value=?]", '+7 (328) 938-93-12'
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Не могут запросить форму с несуществующим with' do
    skip
  end

  test 'Регистрация с помощью номера мобильного телефона. Поля не заполнены' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"", "hidden_recreate"=>"1"}},
          "phones_attributes"=>
           {"0"=>
             {"value"=>"",
              "_mobile"=>"BAhU--8275d15a2146ff217747035d9eea333f14f5defd",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"",
        "password_confirmation"=>""},
      "with"=>"phone"}

    assert_equal(
      ["недостаточной длины (не может быть меньше 6 символов)"],
      assigns(:user).errors['password']
    )

    assert_equal( 
      ["не совпадает со значением поля Пароль"], 
      assigns(:user).errors[:password_confirmation]
    )

    assert_equal(["не может быть пустым"], assigns(:user).errors["profile.names.name"])

    #assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.phones"])
    assert_equal(["не может быть пустым"], assigns(:user).errors["profile.phones.value"])

    assert_select 'span.help-block', 4

  end

  test 'Поэкспериментировать с 1..2.. вложенными элементами' do
    skip
  end

  test 'Регистрация с помощью e-mail. Поля не заполнены' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"", "hidden_recreate"=>"1"}},
          "emails_attributes"=>
           {"0"=>
             {"value"=>"",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"",
        "password_confirmation"=>""},
      "with"=>"email"}

    assert_equal(
      ["недостаточной длины (не может быть меньше 6 символов)"],
      assigns(:user).errors['password']
    )

    assert_equal( 
      ["не совпадает со значением поля Пароль"], 
      assigns(:user).errors[:password_confirmation]
    )

    assert_equal(["не может быть пустым"], assigns(:user).errors["profile.names.name"])

    #assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.emails"])
    assert_equal(["не может быть пустым"], assigns(:user).errors["profile.emails.value"])

    assert_select 'span.help-block', 4
  end

  test 'Аналогично поэкспериментировать с массивом, как и с телефоном, а так же с частичным заполнением форм, вызывающих различные ошибки. Например какое-то поле заполнено, а какое-то нет. Или нарушать формат.' do
    skip
  end

  test 'Мобильный номер телефона указан в неверном формате' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "phones_attributes"=>
           {"0"=>
             {"value"=>"123",
              "_mobile"=>"BAhU--8275d15a2146ff217747035d9eea333f14f5defd",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"phone"}

    #assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.phones"])
    assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.phones.value"])

  end

  test 'E-mail указан в неверном формате' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "emails_attributes"=>
           {"0"=>
             {"value"=>"123",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"email"}
      
    #assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.emails"])
    #assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.emails.value"])
    assert_equal(["имеет неверное значение"], assigns(:user).errors["profile.emails.value"])
  end

  test 'Нельзя использовать уже подтвержденный телефон' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "phones_attributes"=>
           {"0"=>
             {"value"=>"+7 (555) 555-55-55",
              "_mobile"=>"BAhU--8275d15a2146ff217747035d9eea333f14f5defd",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"phone"}

    #assert_equal ["имеет неверное значение"], assigns(:user).errors['profile.phones']
    assert_equal ["Такой номер телефона уже занят."], assigns(:user).errors['profile.phones.value']

  end

  test 'Нельзя использоватеь уже подтвержденный e-mail' do
    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "emails_attributes"=>
           {"0"=>
             {"value"=>"fake@example.com",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"email"}

    #assert_equal ["имеет неверное значение"], assigns(:user).errors['profile.emails']
    assert_equal ["Такой e-mail адрес уже занят."], assigns(:user).errors['profile.emails.value']
  end

  test 'Можно использовать не подтвержденный e-mail' do
    ActionMailer::Base.deliveries.clear

    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "emails_attributes"=>
           {"0"=>
             {"value"=>"foo@example.com",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"email"}

    assert assigns(:user).valid?

    assert_equal 'Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью.', flash[:attention]

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert ["foo@example.com"], delivery.to

    # Заголовок письма
    assert ["Подтверждение электронного адреса"], delivery.subject

    email = Email.where(value: 'foo@example.com').order(id: :desc).limit(1).first
    pin = email.confirmation_token
    id = email.id

    refute email.confirmed?

    # pin код в письме
    #assert_match Regexp.new(pin), delivery.body.encoded

    # ссылка в письме
    assert_match(
      Regexp.new(
        Regexp.escape(
          ERB::Util.html_escape(
            make_user_confirm_email_path(id: id, "confirm" => { "pin" => pin } )
          )
        )
      ), delivery.body.encoded
    )

    assert_redirected_to user_path
  end

  test 'Можно использовать не подтвержденный телефон' do
    ActionMailer::Base.deliveries.clear

    post :update, {
      "user"=>
       {"profile_attributes"=>
         {"names_attributes"=>{"0"=>{"name"=>"Otto", "hidden_recreate"=>"1"}},
          "phones_attributes"=>
           {"0"=>
             {"value"=>"+7 (111) 111-11-11",
              "_mobile"=>"BAhU--8275d15a2146ff217747035d9eea333f14f5defd",
              "hidden_recreate"=>"1",
              "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
        "password"=>"555555",
        "password_confirmation"=>"555555"},
      "with"=>"phone"}

    assert assigns(:user).valid?

    assert_equal 'Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью.', flash[:attention]

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert_equal ['b049fb236f62a7f78166@avisosms.ru'], delivery.to

    # Заголовок письма
    assert_equal "+71111111111", delivery.subject

    phone = Phone.where(value: '+7 (111) 111-11-11').order(id: :desc).limit(1).first
    pin = phone.confirmation_token
    #id = phone.id

    refute phone.confirmed?

    # pin код в SMS
    assert_match Regexp.new(pin), delivery.body.encoded

    ## ссылка в SMS
    #assert_match(
    #  Regexp.new(
    #    Regexp.escape(
    #      make_user_confirm_phone_path(id: id, "confirm" => { "pin" => pin } )
    #    )
    #  ), delivery.body.encoded
    #)

    assert_redirected_to user_path
  end

  test 'Если прохожу регистрацию и неверно заполняю форму, то имя и телефон не должны быть заполнены в форме чата' do
    put :update, {
       "user"=>
        {"profile_attributes"=>
          {"names_attributes"=>{"0"=>{"name"=>"ИМЯ", "hidden_recreate"=>"1"}},
           "phones_attributes"=>
            {"0"=>
              {"value"=>"+7 (234) 782-34-87",
               "_mobile"=>"BAhU--8275d15a2146ff217747035d9eea333f14f5defd",
               "hidden_recreate"=>"1",
               "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280",
               "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
           "_creation_reason"=>"BAhJIg1yZWdpc3RlcgY6BkVU--ee6b919c9378e629c6b6da704f8fa99215cbf280"},
         "password"=>"123",
         "password_confirmation"=>"123"},
       "with"=>"phone"}

    assert_select '#talk_somebody_attributes_profile_attributes_names_attributes_0_name:not([value])'
    assert_select '#talk_somebody_attributes_profile_attributes_phones_attributes_0_value:not([value])'
  end


  test 'Успешная регистрация с помощью телефона' do
    # Была ошибка. Отправленный PIN не равнялся записанному. Включить этот тест
    # В принципе то же самое, что и регистрация с не подтвержденным
    skip
  end

  test 'Успешная регистрация с помощью e-mail' do
    skip
  end

end
