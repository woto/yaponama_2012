# encoding: utf-8

require 'test_helper'

class Admin::ProfilesControllerTest < ActionController::TestCase

  def setup
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    @user = somebodies(:otto)
    @confirmed = phones(:otto2)
    @not_confirmed = phones(:otto)
    @confirmed_email = emails(:otto2)
    @not_confirmed_email = emails(:otto)
    ActionMailer::Base.deliveries = [] 
  end

  test 'Если создаем и не ставим галочку подтверждения' do
    assert_difference 'Phone.count' do
      post :create, 'profile' => { 'names_attributes' => { '0' => { 'name' => 'Отто' } }, 'phones_attributes' => { '0' => { 'value' => '+7 (492) 354-29-51', 'mobile' => '1' } } }, user_id: @user.id
    end

    phone = Phone.last
    refute phone.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.any?, 'То должно отправиться уведомление'
  end

  test 'Если создаем и ставим галочку подтверждения' do
    assert_difference 'Phone.count' do
      post :create, 'profile' => { 'names_attributes' => { '0' => { 'name' => 'Отто' } }, 'phones_attributes' => { '0' => { 'value' => '+7 (491) 392-12-42', 'mobile' => '1', 'confirmed' => '1' } } }, user_id: @user.id
    end

    phone = Phone.last
    assert phone.confirmed?, 'То должен быть подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'То уведомление не должно быть отправлено'
  end

  test 'Если создаем не мобильный и не ставим подтверждение' do
    assert_difference 'Phone.count' do
      post :create, 'profile' => { 'names_attributes' => { '0' => { 'name' => 'Отто' } }, 'phones_attributes' => { '0' => { 'value' => '+7 (492) 354-29-51', 'mobile' => '0' } } }, user_id: @user.id
    end

    phone = Phone.last
    refute phone.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не отправляется, т.к. не мобильный'
  end


  # НЕ СУЩЕСТВЕННОЕ ИЗМЕНЕНИЕ

  test 'Если не существенно меняется и подтверждено' do
    patch :update, 'profile' => { 'emails_attributes' => { '0' => { 'value' => 'FaKe@example.com', 'id' => @confirmed_email.id } } }, 'id' => @confirmed_email.profile.id, 'user_id' => @user.id


    assert @confirmed.reload.confirmed?, 'То остается подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не должно быть отправлено'
  end

  test 'Если не существенно меняется и не подтверждено' do
    patch :update, 'profile' => { 'emails_attributes' => { '0' => { 'value' => 'FoO@example.com', 'id' => @not_confirmed_email.id } } }, 'id' => @not_confirmed_email.profile.id, 'user_id' => @user.id

    refute @not_confirmed_email.reload.confirmed?, 'То остается не подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'Уведомление не должно быть отправлено'
  end

  # СУЩЕСТВЕННОЕ ИЗМЕНЕНИЕ

  test 'Если существенно изменяется подтвержденный и убираем галочку подтверждения' do
    patch :update, 'profile' => { 'phones_attributes' => { '0' => { 'value' => '+7 (666) 666-66-66', 'confirmed' => '0', 'id' => @confirmed.id } } }, 'id' => @confirmed.profile.id, 'user_id' => @user.id

    refute @confirmed.reload.confirmed?, 'То должен быть не подтвержденным'
    assert ActionMailer::Base.deliveries.any?, 'То должно отправиться уведомление о подтверждении'
  end

  test 'Если существенно изменяется не подтвержденный, и ставим галочку подтверждения' do
    patch :update, 'profile' => { 'phones_attributes' => { '0' => { 'value' => '+7 (666) 666-66-66', 'confirmed' => '1', 'id' => @not_confirmed.id } } }, 'id' => @not_confirmed.profile.id, 'user_id' => @user.id

    assert @not_confirmed.reload.confirmed?, 'Статус должен стать подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'То уведомление не должно отправиться'
  end

  test 'Если существенно меняется подтвержденный и сохраняем выставленную галочку (не отправляем в запросе, что равносильно выставлению)' do
    patch :update, 'profile' => { 'phones_attributes' => { '0' => { 'value' => '+7 (666) 666-66-66', 'id' => @confirmed.id } } }, 'id' => @confirmed.profile.id, 'user_id' => @user.id

    assert @confirmed.reload.confirmed?, 'То должен быть подтвержденным'
    assert ActionMailer::Base.deliveries.empty?, 'То не должно отправиться уведомление о подтверждении'
  end

end
