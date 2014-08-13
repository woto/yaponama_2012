# encoding: utf-8
#
require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
    @user = somebodies(:mark)
    @phone = phones(:mark)
    @email = emails(:mark)
    cookies[:auth_token] = @user.auth_token
  end

  test 'Если покупатель не изменив профиль с подтвержденным контактными данным отправил форму, то статусы подтвержденности должны остаться прежними' do
    cookies[:auth_token] = somebodies(:otto).auth_token

    post :update, { "profile"=>
      {"names_attributes"=>
       {"0"=>{"surname"=>"", "name"=>"Отто!", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979", "id"=>names(:otto).id}},
       "phones_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "mobile"=>"1",
           "value"=>"+7 (111) 111-11-11",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto).id},
         "1"=>
          {"_destroy"=>"false",
           "mobile"=>"1",
           "value"=>"+7 (555) 555-55-55",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto2).id},
         "2"=>
          {"_destroy"=>"false",
           "mobile"=>"0",
           "value"=>"8-888-888-88-88",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto3).id},
         "3"=>
          {"_destroy"=>"false",
           "mobile"=>"0",
           "value"=>"+7 (666) 666-66-66",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto4).id}},
       "emails_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "value"=>"foo@example.com",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>emails(:otto).id},
         "1"=>
          {"_destroy"=>"false",
           "value"=>"fake@example.com",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>emails(:otto2).id}},
       "somebody_id"=>somebodies(:otto).id,
       "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
       "notes"=>""},
     "id"=>profiles(:otto).id}

    refute phones(:otto).reload.confirmed
    assert phones(:otto2).reload.confirmed
    assert phones(:otto3).reload.confirmed
    refute phones(:otto4).reload.confirmed
    refute emails(:otto).reload.confirmed
    assert emails(:otto2).reload.confirmed

  end

  test 'Если покупатель самостоятельно меняет подтвержденный номер телефона, то он должен стать не подтвержденным и отправится письмо' do
    put :update, {
     "profile"=>
      {"phones_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "mobile"=>"1",
           "value"=>"+7 (444) 444-44-45",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>@phone.id}},
       "somebody_id"=>@user.id,
       "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
       "notes"=>""},
     "id"=>@user.id}

    refute @phone.reload.confirmed
    assert_equal 1, ActionMailer::Base.deliveries.count

  end

  test 'Если покупатель самостоятельно меняет подтвержденный email, то он должен стать не подтвержденным и отправится письмо' do
    put :update, {
     "profile"=>
      {"emails_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "value"=>"mark@example.ru",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>@email.id}},
       "somebody_id"=>@user.id,
       "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
       "notes"=>""},
     "id"=>@user.id}
  end

  test 'Если покупатель не существенно меняет контактные данные, то их статус остается подтвержденным' do
    put :update, {
     "profile"=>
      {"phones_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "mobile"=>"0",
           "value"=>"+74444444444",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>@phone.id}},
       "emails_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "value"=>"MARK@EXAMPLE.COM",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>@email.id}},
       "somebody_id"=>@user.id,
       "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
       "notes"=>""},
     "id"=>@user.id}

    assert @phone.reload.confirmed
    assert @email.reload.confirmed
  end

  test 'Если покупатель хочет добавить новый профиль, то на странице нового профиля должны быть сразу добавлены для ввода имя и телефон.' do
    get 'new', { user_id: 1, resource_class: 'Profile' }
    assert_select '#profile_names_attributes_0_name'
    assert_select '#profile_phones_attributes_0_value'
    assert_select '#profile_passports_attributes_0_passport', false
    assert_select '#profile_emails_attributes_0_value'
  end

  test 'При удалении профиля так же необходимо сбрасывать кешированную версию в somebody' do
    skip
  end

  test 'Сразу задействованы много частей функционала. Проверяем чтобы при ошибке результирующая форма была заполнена правильно. В тесте ничего не добавляем (только ошибочный email), только меняем/удаляем/очищаем значения.' do
    cookies[:auth_token] = somebodies(:otto).auth_token

    put :update, {
     "profile"=>
      {"names_attributes"=>
        {"0"=>{"surname"=>"", "name"=>"Отто", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979", "id"=>"128399616"}},
       "phones_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "mobile"=>"1",
           "value"=>"",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto).id},
         "1"=>
          {"_destroy"=>"false",
           "mobile"=>"1",
           "value"=>"+7 (483) 498-43-89",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto2).id},
         "2"=>
          {"_destroy"=>"1",
           "mobile"=>"0",
           "value"=>"8-888-888-88-88",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto3).id},
         "3"=>
          {"_destroy"=>"false",
           "mobile"=>"0",
           "value"=>"+7 (666) 666-66-66",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>phones(:otto4).id}},
       "emails_attributes"=>
        {"0"=>
          {"_destroy"=>"false",
           "value"=>"",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>emails(:otto).id},
         "1"=>
          {"_destroy"=>"1",
           "value"=>"fake@example.com",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6",
           "id"=>emails(:otto2).id},
         "1407842443948"=>
          {"_destroy"=>"false",
           "value"=>"123",
           "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
           "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
       "somebody_id"=>somebodies(:otto).id,
       "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
       "notes"=>""},
     "id"=>profiles(:otto).id}

    assert_select "#profile_phones_attributes_0__destroy[value=?]", '1'
    assert_select "#profile_phones_attributes_1_value[value=?]", "+7 (483) 498-43-89"
    assert_select "#profile_phones_attributes_2__destroy[value=?]", '1'
    assert_select "#profile_phones_attributes_3_value[value=?]", "+7 (666) 666-66-66"
    assert_select "#profile_emails_attributes_0__destroy[value=?]", '1'
    assert_select "#profile_emails_attributes_1__destroy[value=?]", '1'
    assert_select "#profile_emails_attributes_2_value[value=?]", "123"

  end

end
