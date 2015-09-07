require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test 'Менеджер не может изменить контактные данные гостя' do
    sign_in(users(:manager))
    post :update, {id: users(:guest), user: {email: 'fake@example.com'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Администратор не может изменить контактные данные гостя' do
    sign_in(users(:admin))
    post :update, {id: users(:guest), user: {email: 'fake@example.com'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Менеджер может повысить гостя до пользователя, указав пароль' do
    sign_in(users(:manager))
    post :update, {id: users(:guest), user: {email: 'fake@example.com', role: 'user', password: '12345678'}}
    assert users(:guest).reload.user?
  end

  test 'Администратор может повысить гостя до пользователя, указав пароль' do
    sign_in(users(:admin))
    post :update, {id: users(:guest), user: {email: 'fake@example.com', role: 'user', password: '12345678'}}
    assert users(:guest).reload.user?
  end

  test 'Администратор может повысить гостя до менеджера, указав пароль' do
    sign_in(users(:admin))
    post :update, {id: users(:guest), user: {email: 'fake@example.com', role: 'manager', password: '12345678'}}
    assert users(:guest).reload.manager?
  end

  test 'Менеджер не может изменить данные у другого менеджера' do
    manager = User.create!(role: 'manager', email: 'some_email@example.com', password: '12345678')
    sign_in(users(:manager))
    post :update, {id: manager.id, user: {email: 'fake@example.com'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Администратор может изменить данные менеджера' do
    manager = User.create!(role: 'manager', email: 'some_email@example.com', password: '12345678')
    sign_in(users(:admin))
    post :update, {id: manager.id, user: {email: 'fake@example.com'}}
    assert_equal 'fake@example.com', manager.reload.email
  end

  test 'Администратор может изменить данные администратора' do
    admin = User.create!(role: 'admin', email: 'some_email@example.com', password: '12345678')
    sign_in(users(:admin))
    post :update, {id: admin.id, user: {email: 'fake@example.com'}}
    assert_equal 'fake@example.com', admin.reload.email
  end


  test 'Менеджер не может изменить данные у администратора' do
    sign_in(users(:manager))
    post :update, {id: users(:admin), user: {email: 'fake@example.com'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Менеджер может изменить свои контактные данные' do
    sign_in(users(:manager))
    post :update, {id: users(:manager), user: {email: 'fake@example.com'}}
    assert_equal 'fake@example.com', users(:manager).reload.email
  end


  test 'Менеджер не может изменить свою роль' do
    sign_in(users(:manager))
    post :update, {id: users(:manager), user: {role: 'admin'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

end
