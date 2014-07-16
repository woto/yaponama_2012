# encoding: utf-8
#
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test 'Проверка отображения ссылок для подтверждения у пользователя' do

    cookies['auth_token'] = somebodies(:otto).auth_token

    get :index

    assert_select '.confirm-phone', count: 1 do |link|
      assert_select "a[href=?]", /\/user\/phones\/\d+\/confirm\/view.*/
      assert_select "a", text: '+7 (111) 111-11-11'
    end

    assert_select '.confirm-email', count: 1 do |link|
      assert_select "a[href=?]", /\/user\/emails\/\d+\/confirm\/view.*/
      assert_select "a", text: 'foo@example.com'
    end

    #assert_match /\/user\/emails\/\d+\/confirm/, find('a', text: 'Подтвердить')['href']

  end

  test "Если посетитель запрашивает страницу с несуществующим auth_token'ом, то он должен быть перенаправлен на главную страницу и auth_token должен быть сброшен." do

    cookies['auth_token'] = 'auth_token_of_nonexistent_user'
    get :index
    assert_redirected_to('/')
    assert_nil cookies['auth_token']
  end

  test "Если посетитель впервые посещает сайт, то в базе должен добавиться пользователь. А клиенту назначен auth_token соответствующий новой записи. creation_reason пользователя должен быть session" do

    assert_difference('User.count'){get :index}
    assert_not_nil cookies['auth_token']
    user = User.last
    assert_equal user.auth_token, cookies['auth_token']
    assert_equal 'session', user.creation_reason
  end

  test 'Новому пользователю без auth_token должен записаться auth_token и role в cookies' do
    get :index
    assert_not_nil cookies['auth_token']
    assert_not_nil cookies['role']
    
  end

  test 'В ситуациях когда к нам зашел посетитель, а потом мы произвели очистку в базе пользователей, то при следующем посещении мы не хотим показывать посетителю какие-то сообщения связанные с аутентификацией, а тихо перегенировываем его auth_token и редиректим на главную(?)' do
    cookies[:auth_token] = '123'
    cookies[:role] = 'guest'
    get :index
    assert_redirected_to :root
    assert_equal '', flash[:attention]
  end

  test 'В ситуациях когда роль не гость и мы не нашли auth_token в базе, то говорим, о том, что мы произвели автовыход' do
    cookies[:auth_token] = '123'
    cookies[:role] = 'user'
    get :index
    assert_redirected_to :root
    assert_equal 'Вы посещали сайт с другого комьютера, в целях безопасности мы автоматически сделали автовыход со всех прочих устройств. Вы можете отключить функцию автоматического выхода в Личном кабинете для возможности одновременной работы с разных компьютеров.', flash[:attention]
  end

  test 'Сделать проверку @meta_...' do

  end

end
