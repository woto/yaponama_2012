require 'test_helper'

class Users::RegistrationsTest < ActionDispatch::IntegrationTest
  
  test 'После регистрации вызывается move_to и текущий пользователь удаляется. К сожалению замокать не удалось.' do
    get '/'
    old_user = User.last
    old_user.postal_addresses.create!(city: '1', street: '1', house: '1', region: '1', postcode: '123456')
    post user_registration_path, {user: {email: 'new@example.com', password: '123123123', password_confirmation: '123123123'}}
    new_user = User.last
    refute_equal new_user, old_user
    assert_raise do
      old_user.reload
    end
    assert new_user.postal_addresses.exists?
  end

  test 'После успешной регистрации нас должно перебросить на /user' do
    get '/'
    assert_difference -> {User.count}, 0 do
      post user_registration_path, {user: {email: 'fake@example.com', password: '12345678', password_confirmation: '12345678'}}
    end
    assert_redirected_to user_path
  end

  test 'Если не ввели email' do
    get '/'
    assert_difference -> {User.count}, 0 do
      post user_registration_path, {user: {password: '12345678', password_confirmation: '12345678'}}
    end
  end

  test 'Если не ввели пароль' do
    get '/'
    assert_difference -> {User.count}, 0 do
      post user_registration_path, {user: {email: 'fake@example.com', password_confirmation: '12345678'}}
    end
  end

  test 'Если не ввели подтверждение пароля' do
    get '/'
    assert_difference -> {User.count}, 0 do
      post user_registration_path, {user: {email: 'fake@example.com', password: '12345678'}}
    end
  end

  test 'Если подтверждение пароля не совпало' do
    get '/'
    assert_difference -> {User.count}, 0 do
      post user_registration_path, {user: {email: 'fake@example.com', password: '12345678', password_confirmation: '11111111'}}
    end
  end

end
