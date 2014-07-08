# encoding: utf-8
#
require 'test_helper'

class RegistersControllerTest < ActionController::TestCase

  test 'Зарегистрироваться может только пользователь с ролью guest' do
    skip
  end

  test 'Форма регистрации с помощью e-mail' do
    get :edit, { with: 'email' }
    assert_select "[name='user[profiles_attributes][0][names_attributes][0][name]']"
    assert_select "[name='user[profiles_attributes][0][emails_attributes][0][value]']"
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Форма регистрации с помощью телефона' do
    get :edit, { with: 'phone' }
    assert_select "[name='user[profiles_attributes][0][names_attributes][0][name]']"
    assert_select "[name='user[profiles_attributes][0][phones_attributes][0][value]']"
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Не могут запросить форму без with' do
    skip
  end

  test 'Не могут запросить форму с несуществующим with' do
    skip
  end

  test 'Регистрация с помощью номера мобильного телефона. Поля не заполнены' do
    post :update, {
      "with" => "phone",
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "phones_attributes" => {
              "0" => {
                "value" => "", "hidden_recreate" => "1", "_mobile" => 'BAhU--d81a713a950620f2d5fe97f05fac06ce87b1729f', "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }

    assert_equal(
      ["не может быть пустым", "недостаточной длины (не может быть меньше 6 символа)"], 
      assigns(:user).errors['password']
    )

    assert_equal( 
      ["не может быть пустым", "не совпадает со значением поля Пароль"], 
      assigns(:user).errors[:password_confirmation]
    )

    assert_equal(["не может быть пустым"], assigns(:user).errors["profiles.names.name"])

    assert_equal(["не может быть пустым"], assigns(:user).errors["profiles.phones.value"])

    assert_select 'span.help-block', 4

  end

  test 'Поэкспериментировать с 1..2.. вложенными элементами' do
    skip
  end

  test 'Регистрация с помощью e-mail. Поля не заполнены' do
    post :update, {
      "with" => "email",
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "", "hidden_recreate" => "1", "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }

    assert_equal(
      ["не может быть пустым", "недостаточной длины (не может быть меньше 6 символа)"], 
      assigns(:user).errors['password']
    )

    assert_equal( 
      ["не может быть пустым", "не совпадает со значением поля Пароль"], 
      assigns(:user).errors[:password_confirmation]
    )

    assert_equal(["не может быть пустым"], assigns(:user).errors["profiles.names.name"])

    assert_equal(["не может быть пустым"], assigns(:user).errors["profiles.emails.value"])

    assert_select 'span.help-block', 4
  end

  test 'Аналогично поэкспериментировать с массивом, как и с телефоном, а так же с частичным заполнением форм, вызывающих различные ошибки. Например какое-то поле заполнено, а какое-то нет. Или нарушать формат.' do
    skip
  end

  test 'Мобильный номер телефона указан в неверном формате' do
    post :update, {
      "with" => "phone",
        "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "phones_attributes" => {
              "0" => {
                "value" => "123", "hidden_recreate" => "1", "_mobile" => 'BAhU--d81a713a950620f2d5fe97f05fac06ce87b1729f', "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
    assert_equal(["имеет неверное значение"], assigns(:user).errors["profiles.phones.value"])

  end

  test 'E-mail указан в неверном формате' do
    post :update, {
      "with" => "email",
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "123", "hidden_recreate" => "1", "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
    assert_equal(["имеет неверное значение"], assigns(:user).errors["profiles.emails.value"])
  end

  test 'Нельзя использовать уже подтвержденный телефон' do
    post :update, {
      "with" => "phone",
      "user" =>
        {
          "profiles_attributes" =>
            {
              "0" =>
                {
                  "names_attributes" => {
                    "0" => {
                      "name" => "Otto", "hidden_recreate" => "1"
                    }
                  },
                  "phones_attributes" => {
                    "0" => {
                      "value" => "+7 (555) 555-55-55", "hidden_recreate" => "1", "_mobile" => 'BAhU--d81a713a950620f2d5fe97f05fac06ce87b1729f', "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
                    }
                  }
                }
            },
          "password" => "555555",
          "password_confirmation" => "555555"
        }
    }
    assert_equal ["Такой номер телефона уже занят."], assigns(:user).errors['profiles.phones.value']

  end

  test 'Нельзя использоватеь уже подтвержденный e-mail' do
    post :update, {
      "with" => "email",
      "user" =>
        {
          "profiles_attributes"=>
            {
              "0"=>
                {
                  "names_attributes" => {
                    "0" => {
                      "name" => "Otto", "hidden_recreate" => "1"
                    }
                  },
                  "emails_attributes" => {
                    "0" => {
                      "value" => "fake@example.com", "hidden_recreate"=>"1", "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
                    }
                  }
                }
            },
          "password"=>"555555",
          "password_confirmation"=>"555555"
        }
    }
    assert_equal ["Такой e-mail адрес уже занят."], assigns(:user).errors['profiles.emails.value']
  end

  test 'Можно использовать не подтвержденный e-mail' do
    post :update, {
      "with" => "email",
      "user" =>
        {
          "profiles_attributes"=>
            {
              "0"=>
                {
                  "names_attributes" => {
                    "0" => {
                      "name" => "Otto", "hidden_recreate"=>"1"
                    }
                  },
                  "emails_attributes" => {
                    "0" => {
                      "value" => "foo@example.com", "hidden_recreate"=>"1", "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
                    }
                  }
                }
            },
          "password"=>"555555",
          "password_confirmation"=>"555555"
        }
    }

    assert assigns(:user).valid?

    assert_equal 'Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью.', flash[:success]

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
    post :update, {
      "with" => "phone",
      "user" =>
        {
          "profiles_attributes" =>
            {
              "0" =>
                {
                  "names_attributes" => {
                    "0" => {
                      "name" => "Otto", "hidden_recreate" => "1"
                    }
                  },
                  "phones_attributes" => {
                    "0" => {
                      "value" => "+7 (111) 111-11-11", "hidden_recreate" => "1", "_mobile" => 'BAhU--d81a713a950620f2d5fe97f05fac06ce87b1729f', "_confirm_required" => "BAhU--3dde4daf45e25d949252ded4cbf2e2ea8f63770b"
                    }
                  }
                }
            },
          "password" => "1111111111",
          "password_confirmation" => "1111111111"
        }
    }

    assert assigns(:user).valid?

    assert_equal 'Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью.', flash[:success]

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert_equal [SiteConfig.avisosms_email_address], delivery.to

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


  test 'Успешная регистрация с помощью телефона' do
    # Была ошибка. Отправленный PIN не равнялся записанному. Включить этот тест
    # В принципе то же самое, что и регистрация с не подтвержденным
    skip
  end

  test 'Успешная регистрация с помощью e-mail' do
    skip
  end

end
