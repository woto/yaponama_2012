require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test 'Для правила inet: 192.168.1.0/24 должен определиться как бот клиент 192.168.1.2' do
    Bot.create!(inet: '192.168.1.0/24')
    @request.remote_addr = '192.168.1.2'
    get :index
    assert_nil assigns(:current_user)
  end

  test 'Для правила inet: 192.168.1.0/24 должен определиться как бот клиент 192.168.1.2 и быть заблокированным' do
    Bot.create!(inet: '192.168.1.0/24', block: true)
    @request.remote_addr = '192.168.1.2'
    get :index
    assert_redirected_to 'http://example.com'
  end

  test 'Для правила inet: 192.168.1.0/24 НЕ должен определиться как бот клиент 192.168.2.2' do
    Bot.create!(inet: '192.168.1.0/24')
    @request.remote_addr = '192.168.2.2'
    get :index
    refute_nil assigns(:current_user)
  end

  test 'Для правила user_agent: Mozilla Firefox должен определиться как бот клиент Mozilla Firefox' do
    Bot.create!(user_agent: 'Mozilla Firefox')
    @request.user_agent = 'Mozilla Firefox'
    get :index
    assert_nil assigns(:current_user)
  end

  test 'Для правила user_agent: Mozilla не должен определиться как бот клиент Mozilla Firefox' do
    Bot.create!(user_agent: 'Mozilla')
    @request.user_agent = 'Mozilla Firefox'
    get :index
    refute_nil assigns(:current_user)
  end

  test 'Для правила user_agent: Mozilla Firefox Browser не должен определиться как бот клиент Mozilla Firefox' do
    Bot.create!(user_agent: 'Mozilla Firefox Browser')
    @request.user_agent = 'Mozilla Firefox'
    get :index
    refute_nil assigns(:current_user)
  end

  test 'Создавая Bot с пустым user_agent должно записаться nil' do
    bot = Bot.create!(user_agent: '', inet: '0.0.0.0')
    assert_equal nil, bot.user_agent
  end

  test 'Создавая Bot с пустым inet должно записаться nil' do
    bot = Bot.create!(user_agent: 'Google Chrome', inet: '')
    assert_equal nil, bot.inet
  end


  test 'Если условие и на user_agent и на inet, то они должны оба совпадать при проверке 1' do
    bot = Bot.create!(user_agent: 'Mozilla Firefox', inet: '192.168.0.0/24')
    @request.user_agent = 'Mozilla Firefox'
    get :index
    refute_nil assigns(:current_user)
  end

  test 'Если условие и на user_agent и на inet, то они должны оба совпадать при проверке 2' do
    bot = Bot.create!(user_agent: 'Mozilla Firefox', inet: '192.168.0.0/24')
    @request.remote_addr = '192.168.0.1'
    get :index
    refute_nil assigns(:current_user)
  end

  test 'Если условие и на user_agent и на inet, то они должны оба совпадать при проверке 3' do
    bot = Bot.create!(user_agent: 'Mozilla Firefox', inet: '192.168.0.0/24')
    @request.user_agent = 'Mozilla Firefox'
    @request.remote_addr = '192.168.0.1'
    get :index
    assert_nil assigns(:current_user)
  end







  test 'Проверка отображения ссылок для подтверждения у пользователя' do

    cookies['auth_token'] = somebodies(:otto).auth_token

    get :index

    assert_select '.confirm-phone', count: 1 do |link|
      assert_select "a:match('href', ?)", /\/user\/phones\/\d+\/confirm\/view.*/
      assert_select "a", text: '+7 (111) 111-11-11'
    end

    assert_select '.confirm-email', count: 1 do |link|
      assert_select "a:match('href', ?)", /\/user\/emails\/\d+\/confirm\/view.*/
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
  end

  test 'Сделать проверку @meta_...' do

  end

  test 'Если я гость и у меня есть подтвержденный email, то я должен увидеть предложение зарегистрироваться' do
    cookies['auth_token'] = somebodies(:guest_with_profile2).auth_token
    get :index
    assert_select '#confirm-block .alert-link', "Придумайте себе пароль"
  end

  test 'Если я бот и заблокирован по User-Agent, то меня перекидывает на example.com' do
    @request.headers["User-Agent"] = 'Majestic, Ahrefs'
    get :index
    assert_redirected_to 'http://example.com'
  end

  test 'Если я бот и не заблокирован, то я открываю страницу' do
    @request.headers["User-Agent"] = 'Google, Yandex'
    get :index
    assert_response :success
  end

  test 'При посещении сайта независимо от того не бот я или бот, забаненный или не забаненный статистика посещений должна учитываться' do
    skip
  end

  test 'Написать тест для проверки работоспособности механизма, определяющего бот/"or not" по ip' do
    skip
  end

end
