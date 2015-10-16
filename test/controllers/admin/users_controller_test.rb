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

  test 'Менеджер не может создать гостя' do
    sign_in(users(:manager))
    post :create, {user: {name: 'user', role: 'guest'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Менеджер может создать пользователя' do
    sign_in(users(:manager))
    assert_difference -> {User.count} do
      post :create, {user: {name: 'fake', role: 'user', email: 'fake@example.com', password: '12345678'}}
    end
  end

  test 'Менеджер не может создать менеджера' do
    sign_in(users(:manager))
    post :create, {user: {name: 'user', role: 'manager'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Менеджер не может создать администратора' do
    sign_in(users(:manager))
    post :create, {user: {name: 'user', role: 'admin'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Администратор не может создать гостя' do
    sign_in(users(:admin))
    post :create, {user: {name: 'user', role: 'guest'}}
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Администратор может создать пользователя' do
    sign_in(users(:admin))
    assert_difference -> {User.count} do
      post :create, {user: {name: 'fake', role: 'user', email: 'fake@example.com', password: '12345678'}}
    end
  end

  test 'Администратор может создать менеджера' do
    sign_in(users(:admin))
    assert_difference -> {User.count} do
      post :create, {user: {name: 'fake', role: 'manager', email: 'fake@example.com', password: '12345678'}}
    end
  end

  test 'Администратор может создать администратора' do
    sign_in(users(:admin))
    assert_difference -> {User.count} do
      post :create, {user: {name: 'fake', role: 'admin', email: 'fake@example.com', password: '12345678'}}
    end
  end

  test 'Менеджер может стать гостем' do
    sign_in(users(:manager))
    get :impersonate, id: users(:guest)
    assert_redirected_to user_path
  end

  test 'Менеджер может стать пользователем' do
    sign_in(users(:manager))
    get :impersonate, id: users(:user)
    assert_redirected_to user_path
  end

  test 'Менеджер не может стать другим менеджером' do
    sign_in(users(:manager1))
    get :impersonate, id: users(:manager2)
    assert_redirected_to admin_root_path
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Менеджер не может стать администратором' do
    sign_in(users(:manager))
    get :impersonate, id: users(:admin)
    assert_redirected_to admin_root_path
    assert_equal 'Недостаточно прав для данного действия', flash[:alert]
  end

  test 'Администратор может стать менеджером' do
    sign_in(users(:admin))
    get :impersonate, id: users(:manager)
    assert_redirected_to user_path
  end

  test 'Если мы становимся гостем, то должен сброситься переменная сессии warden.user.user.key и присвоиться guest_user_id гостя' do
    sign_in(users(:manager))
    assert session["warden.user.user.key"]
    refute session["guest_user_id"]
    get :impersonate, {id: users(:guest)}
    refute session["warden.user.user.key"]
    assert session["guest_user_id"]
  end

end
