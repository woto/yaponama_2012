require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase

  def setup
    @guest = somebodies(:guest)
    @guest_id = @guest.id
  end

  test 'Проверяем наличие полей ввода Имя, Телефон, Email, Почтовый Индекс' do
    get :new
    assert_select '#payment_new_profile_attributes_names_attributes_0_name'
    assert_select '#payment_new_profile_attributes_phones_attributes_0_value'
    assert_select '#payment_new_profile_attributes_emails_attributes_0_value'
    assert_select '#payment_new_postal_address_attributes_postcode'

  end

  test 'Успешная оплата с помощью QIWI' do
    cookies[:auth_token] = @guest.auth_token

    post :create,  { "payment"=>
      {"payment_type"=>"Qiwi29OceanR",
       "amount"=>"100",
       "profile_type"=>"new",
       "old_profile_id"=>"",
       "new_profile_attributes"=>
        {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"ИМЯ", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
         "phones_attributes"=>
          {"0"=>
            {"_destroy"=>"false",
             "mobile"=>"1",
             "value"=>"+7 (477) 834-87-23",
             "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
             "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
         "somebody_id"=>@guest_id,
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
         "notes"=>""},
       "postal_address_type"=>"new",
       "old_postal_address_id"=>"",
       "new_postal_address_attributes"=>
        {"postcode"=>"",
         "region"=>"",
         "city"=>"",
         "street"=>"",
         "house"=>"",
         "stand_alone_house"=>"0",
         "room"=>"",
         "somebody_id"=>@guest_id,
         "notes"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
       "somebody_id"=>@guest_id}}

      assert_redirected_to user_payment_path(assigns(:resource))

  end

  test 'Успешная оплата с помощью квитанции Сбербанка' do
    cookies[:auth_token] = @guest.auth_token

    post :create, { "payment"=>
      {"payment_type"=>"Sberbank",
       "amount"=>"100",
       "profile_type"=>"new",
       "old_profile_id"=>"",
       "new_profile_attributes"=>
        {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"ИМЯ", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
         "phones_attributes"=>
          {"0"=>
            {"_destroy"=>"false",
             "mobile"=>"0",
             "value"=>"ТЕЛЕФОН",
             "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
             "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
         "somebody_id"=>@guest_id,
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
         "notes"=>""},
       "postal_address_type"=>"new",
       "old_postal_address_id"=>"",
       "new_postal_address_attributes"=>
        {"postcode"=>"123456",
         "region"=>"1",
         "city"=>"1",
         "street"=>"1",
         "house"=>"1",
         "stand_alone_house"=>"1",
         "room"=>"",
         "somebody_id"=>@guest_id,
         "notes"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
       "somebody_id"=>""}}

    assert_redirected_to user_payment_path(assigns(:resource))
  end

  test 'Не успешная оплата с помощью QIWI (т.к. не введена сумма)' do
    cookies[:auth_token] = @guest.auth_token

    post :create, {
      "payment"=>
       {"payment_type"=>"Qiwi29OceanR",
        "amount"=>"",
        "profile_type"=>"new",
        "old_profile_id"=>"",
        "new_profile_attributes"=>
         {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"ИМЯ", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
          "phones_attributes"=>
           {"0"=>
             {"_destroy"=>"false",
              "mobile"=>"0",
              "value"=>"ТЕЛЕФОН",
              "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "emails_attributes"=>
           {"0"=>
             {"_destroy"=>"false",
              "value"=>"",
              "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "somebody_id"=>@guest_id,
          "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
          "notes"=>""},
       "postal_address_type"=>"new",
       "old_postal_address_id"=>"",
       "new_postal_address_attributes"=>
        {"postcode"=>"",
         "region"=>"",
         "city"=>"",
         "street"=>"",
         "house"=>"",
         "stand_alone_house"=>"0",
         "room"=>"",
         "somebody_id"=>@guest_id,
         "notes"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
       "somebody_id"=>@guest_id}}

    assert_select '#payment_new_profile_attributes_names_attributes_0_name'
    assert_select '#payment_new_profile_attributes_phones_attributes_0_value'
    assert_select '#payment_new_profile_attributes_emails_attributes_0_value'
    assert_select '#payment_new_postal_address_attributes_postcode'

  end

  test 'Не успешная оплата с помощью Сбербанка (т.к. введен неверно индекс)' do
    cookies[:auth_token] = @guest.auth_token

    post :create, {
      "payment"=>
       {"payment_type"=>"Sberbank",
        "amount"=>"100",
        "profile_type"=>"new",
        "old_profile_id"=>"",
        "new_profile_attributes"=>
         {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"ИМЯ", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
          "phones_attributes"=>
           {"0"=>
             {"_destroy"=>"false",
              "mobile"=>"0",
              "value"=>"ТЕЛЕФОН",
              "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "emails_attributes"=>
           {"0"=>
             {"_destroy"=>"false",
              "value"=>"",
              "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
              "_confirmed"=>"BAgw--9cd2826b363ae4eca4108a4dd6ea8ac718e088e6"}},
          "somebody_id"=>@guest_id,
          "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
          "notes"=>""},
        "postal_address_type"=>"new",
        "old_postal_address_id"=>"",
        "new_postal_address_attributes"=>
         {"postcode"=>"НЕ ПРАВИЛЬНЫЙ",
          "region"=>"1",
          "city"=>"1",
          "street"=>"1",
          "house"=>"1",
          "stand_alone_house"=>"1",
          "room"=>"",
          "somebody_id"=>@guest_id,
          "notes"=>"",
          "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
        "somebody_id"=>""}}


    assert_equal ["имеет неверное значение"], assigns(:resource).errors[:new_postal_address]

    assert_select '#payment_new_profile_attributes_names_attributes_0_name'
    assert_select '#payment_new_profile_attributes_phones_attributes_0_value'
    assert_select '#payment_new_profile_attributes_emails_attributes_0_value'
    assert_select '#payment_new_postal_address_attributes_postcode'

  end

end
