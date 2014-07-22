# encoding: utf-8
#
require 'test_helper'

class ConfirmsControllerTest < ActionController::TestCase

  test 'Если я подтверждаю контакт гостя, то меня редиректит на стр. регистрации и пишут чтобы зарегился' do
    id = emails(:guest_with_profile).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: '8888' }
    assert_redirected_to edit_register_path(with: :email)
    assert_equal 'guest_with_profile@example.com успешно подтвержден.', flash[:attention]
    # TODO у нас рендерится js, который пробрасывает с помощью Turbolinks на нужную страницу
  end

  test 'Отправка формы с PIN кодом со страницы подтверждения e-mail. PIN код правильный' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: '5555' }
    assert emails(:otto).reload.confirmed?
    assert_equal 'foo@example.com успешно подтвержден.', flash[:attention]
    assert_redirected_to user_path
    # TODO у нас рендерится show.js.erb, можно ли это проверить?
  end

  test 'Отправка формы с PIN кодом со страницы подтверждения phone. PIN код правильный' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    xhr :get, :make, id: id, resource_class: 'Phone', confirm: { pin: '5555' }
    assert phones(:otto).reload.confirmed?
    assert_equal '+7 (111) 111-11-11 успешно подтвержден.', flash[:attention]
    assert_redirected_to user_path
    # TODO у нас рендерится show.js.erb, можно ли это проверить?
  end

  test 'Проверка отображения и адреса ссылки для высылки PIN кода для подтверждения e-mail' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto).id
    xhr :get, :view, id: id, resource_class: 'Email'
    assert response.body.include?("/user/emails/#{id}/confirm/ask")
  end

  test 'Проверка отображения и адреса ссылки для высылки PIN кода для подтверждения phone' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    xhr :get, :view, id: id, resource_class: 'Phone'
    assert response.body.include?("/user/phones/#{id}/confirm/ask")
  end

  test 'Проверка работы ссылки запроса PIN кода на e-mail' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto).id
    xhr :post, :ask, id: id, resource_class: 'Email'

    # Проверка редиректа на страницу ввода pin кода
    assert_redirected_to view_user_confirm_email_path(id: id)

    # Проверка оповещения flash
    assert_equal 'Мы отправили вам электронное письмо с PIN кодом. Введите его в поле, расположенное ниже, либо перейдите по ссылке в письме. Не забудьте проверить папку спам, если долго не получаете письмо.', flash[:info]

    pin = emails(:otto).reload.confirmation_token

    # pin код действительно изменился
    refute_equal '5555', pin

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert_equal ["foo@example.com"], delivery.to

    # Заголовок письма
    assert_equal "Подтверждение электронного адреса", delivery.subject

    # pin код в письме
    # TODO
    #assert_match Regexp.new("PIN.*" + pin), delivery.body.encoded

    # ссылка в письме
    assert_select_email do
      assert_select 'a[href=?]', make_user_confirm_email_url(id: id, "confirm" => { "pin" => pin } )
    end 

  end

  test 'Проверка работы ссылки запроса PIN кода на телефон' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    post :ask, id: id, resource_class: 'Phone'

    # Проверка редиректа на страницу ввода pin кода
    assert_redirected_to view_user_confirm_phone_path(id: id)

    # Проверка оповещения flash
    assert_equal 'Мы отправили вам SMS с PIN кодом. Введите его в поле, расположенное ниже, либо перейдите по ссылке если ваш телефон поддерживает эту функцию.', flash[:info]

    pin = phones(:otto).reload.confirmation_token

    # pin код действительно изменился
    refute_equal '5555', pin

    delivery = ActionMailer::Base.deliveries.last

    # Адресат письма
    assert_equal ['b049fb236f62a7f78166@avisosms.ru'], delivery.to

    # Заголовок письма
    assert_equal "+71111111111", delivery.subject

    # pin код в SMS
    assert_match Regexp.new(pin), delivery.body.encoded

    ## ссылка в SMS
    # TODO
    #assert_match(
    #  Regexp.new(
    #    Regexp.escape(
    #      make_user_confirm_phone_path(id: id, "confirm" => { "pin" => pin } )
    #    )
    #  ), delivery.body.encoded
    #)

  end

  test 'Проверка отображения формы для ввода PIN кода для подтверждения e-mail' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto).id
    xhr :get, :view, id: id, resource_class: 'Email'
    assert response.body.include?("confirm[pin]")
  end

  test 'Проверка отображения формы для ввода PIN кода для подтверждения phone' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    xhr :get, :view, id: id, resource_class: 'Phone'
    assert response.body.include?("confirm[pin]")
  end


  test 'Мы не можем открыть форму для ввода pin кода подтвержденного email' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto2).id
    get :view, id: id, resource_class: 'Email'
    assert_redirected_to user_path
  end

  test 'Мы не можем открыть форму для ввода pin кода подтвержденного phone' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto2).id
    get :view, id: id, resource_class: 'Phone'
    assert_redirected_to user_path
  end


  test 'Мы не можем запросить ссылку и pin для подтверждения email, который уже подтвержден' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto2).id
    post :ask, id: id, resource_class: 'Email'
    assert_redirected_to user_path
  end

  test 'Мы не можем запросить ссылку и pin для подтверждения phone, который уже подтвержден' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto2).id
    post :ask, id: id, resource_class: 'Phone'
    assert_redirected_to user_path
  end

  test 'Отправка формы с PIN кодом со страницы подтверждения e-mail. PIN код не правильный' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: 'oeia' }
    # TODO 'Тут еще добавить проверку отображения ошибки'
    refute phones(:otto).confirmed?
  end

  test 'Отправка формы с PIN кодом со страницы подтверждения phone. PIN код не правильный' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = phones(:otto).id
    xhr :get, :make, id: id, resource_class: 'Phone', confirm: { pin: 'oeia' }
    # TODO 'Тут еще добавить проверку отображения ошибки'
    refute phones(:otto).confirmed?
  end

  ##
  ## ЗЛОУМЫШЛЕННИК MARK
  ##

  test 'Пользователь не может запросить ссылку и пин код для email, если не владеем им' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = emails(:otto).id
    post :ask, id: id, resource_class: 'Email'
    assert_redirected_to user_path
  end

  test 'Пользователь не может запросить ссылку и пин код для phone, если не владеем им' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = phones(:otto).id
    post :ask, id: id, resource_class: 'Phone'
    assert_redirected_to user_path
  end

  test 'Попытка отображения формы для ввода PIN кода пользователем не владеющим этим email' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = emails(:otto).id
    xhr :get, :view, id: id, resource_class: 'Email'
    assert_redirected_to user_path
  end

  test 'Попытка отображения формы для ввода PIN кода пользователем не владеющим этим phone' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = phones(:otto).id
    get :view, id: id, resource_class: 'Phone'
    assert_redirected_to user_path
  end

  ##
  ## /ЗЛОУМЫШЛЕННИК MARK
  ##

  test 'Отправка формы с PIN кодом со страницы подтверждения phone пользователем не владеющим этим phone. PIN код правильный' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = phones(:otto).id
    get :make, id: id, resource_class: 'Phone', confirm: { pin: '5555' }
    assert phones(:otto).reload.confirmed?
  end


  test 'Отправка формы с PIN кодом со страницы подтверждения email пользователем не владеющим этим phone. PIN код правильный' do
    cookies['auth_token'] = somebodies(:mark).auth_token
    id = emails(:otto).id
    get :make, id: id, resource_class: 'Email', confirm: { pin: '5555' }
    assert emails(:otto).reload.confirmed?
  end

  test 'Отправка формы с PIN кодом со страницы подтверждения phone не аутентифицированным пользователем. PIN код правильный' do
    id = phones(:otto).id
    xhr :get, :make, id: id, resource_class: 'Phone', confirm: { pin: '5555' }
    assert phones(:otto).reload.confirmed?
  end


  test 'Отправка формы с PIN кодом со страницы подтверждения email не аутентифицированным пользователем' do
    id = emails(:otto).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: '5555' }
    assert emails(:otto).reload.confirmed?
  end

  test 'Если подтверждает не аутентифицированный пользователь' do
    id = emails(:otto).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: '5555' }
    assert_redirected_to user_path
  end

  test 'Если подтверждает аутентифицированный пользователь' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    id = emails(:otto).id
    xhr :get, :make, id: id, resource_class: 'Email', confirm: { pin: '5555' }
    assert_redirected_to user_path
  end

  test "Ссылка подтверждения (подтверждаемый id e-mail'a) у пользователя не верна" do
    cookies['auth_token'] = somebodies(:otto).auth_token
    xhr :get, :make, id: 1238492384, resource_class: 'Email', confirm: { pin: '2398428394570294785' }
    assert_redirected_to root_path
  end

  test "Ссылка подтверждения (подтверждаемый id e-mail'a) у неавторизованного пользователя не верна" do
    cookies['auth_token'] = somebodies(:guest).auth_token
    xhr :get, :make, id: 1238492384, resource_class: 'Email', confirm: { pin: '2398428394570294785' }
    assert_redirected_to root_path
  end

end
