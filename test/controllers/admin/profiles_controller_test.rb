# encoding: utf-8
#
require 'test_helper'

class Admin::ProfilesControllerTest < ActionController::TestCase

  def setup
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    @user = somebodies(:otto)
    @confirmed = phones(:otto2)
    @not_confirmed = phones(:otto)
    @confirmed_email = emails(:otto2)
    @not_confirmed_email = emails(:otto)
    ActionMailer::Base.deliveries.clear
  end

  test 'Если создаем и не ставим галочку подтверждения' do
    assert_difference 'Phone.count' do
      post :create, {
       "profile"=>
        {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"Отто", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
         "phones_attributes"=>
          {"0"=>
            {"_destroy"=>"false",
             "mobile"=>"1",
             "value"=>"+7 (723) 482-34-89",
             "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
             "confirmed"=>"0",
             "confirmation_datetime(3i)"=>"12",
             "confirmation_datetime(2i)"=>"8",
             "confirmation_datetime(1i)"=>"2014"}},
         "somebody_id"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
         "notes"=>"",
         "notes_invisible"=>""},
       "user_id"=>@user.id}
    end

    
    phone = Phone.last
    refute phone.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.any?, 'То должно отправиться уведомление'
  end

  test 'Если создаем мобильный и ставим галочку подтверждения' do
    assert_difference 'Phone.count' do
      post :create, {
       "profile"=>
        {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"Отто", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
         "phones_attributes"=>
          {"0"=>
            {"_destroy"=>"false",
             "mobile"=>"1",
             "value"=>"+7 (723) 498-23-49",
             "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
             "confirmed"=>"1",
             "confirmation_datetime(3i)"=>"12",
             "confirmation_datetime(2i)"=>"8",
             "confirmation_datetime(1i)"=>"2014"}},
         "somebody_id"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
         "notes"=>"",
         "notes_invisible"=>""},
       "user_id"=>@user.id}
    end

    phone = Phone.last
    assert phone.confirmed?, 'То должен быть подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'То уведомление не должно быть отправлено'
  end

  test 'Если создаем не мобильный и не ставим подтверждение' do
    assert_difference 'Phone.count' do
      post :create, {
       "profile"=>
        {"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"Отто", "patronymic"=>"", "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"}},
         "phones_attributes"=>
          {"0"=>
            {"_destroy"=>"false",
             "mobile"=>"0",
             "value"=>"+7 (492) 354-29-51",
             "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
             "confirmed"=>"0",
             "confirmation_datetime(3i)"=>"12",
             "confirmation_datetime(2i)"=>"8",
             "confirmation_datetime(1i)"=>"2014"}},
         "somebody_id"=>"",
         "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
         "notes"=>"",
         "notes_invisible"=>""},
       "user_id"=>@user.id}
    end

    phone = Phone.last
    refute phone.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не отправляется, т.к. не мобильный'
  end


  test 'Если мы изменяем подтвержденный email' do
    put :update, { 
      "profile"=> {
        "emails_attributes"=> {
          "0"=> {
            "_destroy"=>"false",
            "value"=>"FaKe@example.com",
            "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
            "confirmed"=>"1",
            "confirmation_datetime(3i)"=>"12",
            "confirmation_datetime(2i)"=>"8",
            "confirmation_datetime(1i)"=>"2014",
            "id"=>@confirmed_email.id}},
        "somebody_id"=>@user.id,
        "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
      "user_id"=>@user.id,
      "id"=>@confirmed_email.profile.id}

    assert @confirmed.reload.confirmed?, 'То остается подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не должно быть отправлено'
  end

  test 'Если мы меняем не подтвержденный email' do
    patch :update, {
      "profile"=> {
        "emails_attributes"=> {
          "0"=> {
            "_destroy"=>"false",
            "value"=>"FoO@example.com",
            "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
            "confirmed"=>"0",
            "confirmation_datetime(3i)"=>"12",
            "confirmation_datetime(2i)"=>"8",
            "confirmation_datetime(1i)"=>"2014",
            "id"=>@not_confirmed_email.id}},
        "somebody_id"=>@user.id,
        "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979" },
      "user_id"=>@user.id,
      "id"=>@not_confirmed_email.profile.id}

    assert assigns(:resource).valid?
    refute @not_confirmed_email.reload.confirmed?, 'То остается не подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не должно быть отправлено'
  end

  test 'Если мы убираем галочку подтверждения' do

    patch :update, { 
      "profile"=> {
        "phones_attributes"=> {
          "0"=> {
            "_destroy"=>"false",
            "mobile"=>"1",
            "value"=>"+7 (555) 555-55-55",
            "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
            "confirmed"=>"0",
            "confirmation_datetime(3i)"=>"12",
            "confirmation_datetime(2i)"=>"8",
            "confirmation_datetime(1i)"=>"2014",
            "id"=>@confirmed.id}},
        "somebody_id"=>@user.id,
        "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
    "user_id"=>@user.id,
    "id"=>@confirmed.profile.id}

    refute @confirmed.reload.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.any?, 'То должно отправиться уведомление о подтверждении'
  end

  test 'Если мы ставим галочку подтверждения' do
    patch :update, "profile" => {
      "phones_attributes" => {
        "0" => {
          "_destroy"=>"false",
          "mobile"=>"1",
          "value"=>"+7 (111) 111-11-11",
          "_creation_reason"=>"BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979",
          "confirmed"=>"1",
          "confirmation_datetime(3i)"=>"12",
          "confirmation_datetime(2i)"=>"8",
          "confirmation_datetime(1i)"=>"2014",
          "id"=>@not_confirmed.id}},
      "somebody_id" => @user.id,
      "_creation_reason" => "BAhJIgxwcm9maWxlBjoGRVQ=--4bae2158afe778b342bf76a1e1f8b7bfa8098979"},
    "user_id" => @user.id,
    "id" => @not_confirmed.profile.id

    assert @not_confirmed.reload.confirmed?, 'Статус должен стать подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'То уведомление не должно отправиться'
  end

  test 'Администратор обновляет не главный профиль' do
    mile = somebodies(:mile)
    old_mile_updated_at = mile.updated_at
    old = mile.cached_profile
    mile_not_main = profiles(:mile_not_main)

    patch :update, 
      {
        "supplier_id" => mile.id,
        "id" => mile_not_main.id,
        "profile" => {
        "names_attributes" => {
          "0" => {
            "surname" => "",
            "name" => "5",
            "patronymic" => "",
            "notes" => "",
            "notes_invisible" => "",
            "hidden_recreate" => "1",
            "id" => names(:mile_not_main).id}},
        "phones_attributes" => {
          "0" => {
            "_destroy" => "false",
            "mobile" => "0",
            "value" => "5",
            "hidden_recreate" => "1",
            "notes" => "",
            "notes_invisible" => "",
            "confirmed" => "0",
            "confirmation_datetime(3i)" => "27",
            "confirmation_datetime(2i)" => "10",
            "confirmation_datetime(1i)" => "2013",
            "id" => phones(:mile_not_main).id}},
        "notes" => "",
        "notes_invisible" => ""}}

    new = mile.reload.cached_profile
    assert_equal new, old, 'cached_profile не должен был измениться'
    assert_equal mile.reload.updated_at, old_mile_updated_at
  end

  test 'Администратор обновляет главный профиль' do
    mile = somebodies(:mile)
    old_mile_updated_at = mile.updated_at
    old = mile.cached_profile
    mile_main = profiles(:mile_main)

    patch :update, {
      "supplier_id" => mile.id,
      "id" => mile_main.id,
      "profile" => {
      "names_attributes" => {
        "0" => {
          "surname" => "",
          "name" => "5",
          "patronymic" => "",
          "notes" => "",
          "notes_invisible" => "",
          "hidden_recreate" => "1",
          "id" => names(:mile_main).id}},
      "phones_attributes" => {
        "0" => {
          "_destroy" => "false",
          "mobile" => "0",
          "value" => "5",
          "hidden_recreate" => "1",
          "notes" => "",
          "notes_invisible" => "",
          "confirmed" => "0",
          "confirmation_datetime(3i)" => "27",
          "confirmation_datetime(2i)" => "10",
          "confirmation_datetime(1i)" => "2013",
          "id" => phones(:mile_main).id}},
      "notes" => "",
      "notes_invisible" => ""}}

    new = mile.reload.cached_profile
    refute_equal new, old, 'cached_profile должен был измениться'
    refute_equal mile.reload.updated_at, old_mile_updated_at
  end


  test 'Проверка сохранения кешированных значений профиля при создании первого профиля' do

    avtorif = somebodies(:avtorif)
    admin = somebodies(:first_admin)

    cookies['auth_token'] = admin.auth_token
    assert_equal 0, avtorif.profiles.count, 'Для этого теста необходимо чтобы вначале не было ни одного профиля'

    post :create, {
      "profile" => {
        "names_attributes" => {
          "0" => {
            "surname" => "фамилия",
            "name" => "имя",
            "patronymic" => "отчество",
            "notes" => "",
            "notes_invisible" => "",
            "hidden_recreate" => "1"}},
        "phones_attributes" => {
          "0" => {
            "mobile" => "0",
            "value" => "телефон",
            "hidden_recreate" => "1",
            "notes" => "",
            "notes_invisible" => "",
            "confirmed" => "0",
            "confirmation_datetime(3i)" => "27",
            "confirmation_datetime(2i)" => "10",
            "confirmation_datetime(1i)" => "2013"}},
        "emails_attributes" => {
          "1382875829779" => {
            "_destroy" => "false",
            "value" => "fake@mail.ru",
            "notes" => "",
            "notes_invisible" => "",
            "confirmed" => "0",
            "confirmation_datetime(3i)" => "27",
            "confirmation_datetime(2i)" => "10",
            "confirmation_datetime(1i)" => "2013",
            "hidden_recreate" => "1"}},
        "passports_attributes" => {
          "1382875837399" => {
            "_destroy" => "false",
            "seriya" => "серия",
            "nomer" => "номер",
            "passport_vidan" => "паспорт выдан",
            "data_vidachi(3i)" => "1",
            "data_vidachi(2i)" => "1",
            "data_vidachi(1i)" => "1913",
            "kod_podrazdeleniya" => "код подразделения",
            "gender" => "male",
            "data_rozhdeniya(3i)" => "1",
            "data_rozhdeniya(2i)" => "1",
            "data_rozhdeniya(1i)" => "1913",
            "mesto_rozhdeniya" => "место рождения",
            "notes" => "",
            "notes_invisible" => "",
            "hidden_recreate" => "1"}},
        "notes" => "", "notes_invisible" => ""},
        "supplier_id" => avtorif.id}

    assert_equal '[{"surname":"фамилия","name":"имя","patronymic":"отчество"}]', Profile.last.cached_names
    assert_equal '[{"value":"телефон"}]', Profile.last.cached_phones
    assert_equal '[{"value":"fake@mail.ru"}]', Profile.last.cached_emails
    assert_equal '[{"seriya":"серия","nomer":"номер","mesto_rozhdeniya":"место рождения"}]', Profile.last.cached_passports

    assert_equal avtorif.reload.profile, Profile.last, 'Созданные единственный профиль почему-то не стал основным'
  end

end
