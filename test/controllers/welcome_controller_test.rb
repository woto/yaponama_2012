require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test 'Проверка выставления ipgeobase' do
    @request.remote_addr = '85.117.95.1'
    get :index
    assert_equal User.last.ipgeobase_name, 'Норильск'
    assert_equal User.last.ipgeobase_names_depth_cache, 'Россия/Сибирский федеральный округ/Красноярский край'
  end

  test 'Проверка выставления User-Agent' do
    @request.user_agent = 'Browser 1'
    get :index
    assert_equal User.last.user_agent, 'Browser 1'
  end

  test 'Проверка выставления Accept-Langugage' do
    @request.headers['Accept-Language'] = 'Language 1'
    get :index
    assert_equal 'Language 1', User.last.accept_language
  end

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

  test 'Если условие для user_agent: знак_процентаChromeзнак_процента, то пользователь с Google Chrome Browser определится как бот' do
    bot = Bot.create!(user_agent: '%Chrome%')
    @request.user_agent = 'Google Chrome Browser'
    get :index
    assert_nil assigns(:current_user)
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

  ############# User

  test 'Если у пользователя левый guest_user_id, то должен создасться новый пользователь и просто вернуться запрошенная страница' do
    assert_difference -> {User.count} do
      get :index, nil, guest_user_id: -1
      assert_response :success
    end
    assert_equal session["guest_user_id"], User.last.id
  end

  test 'Если у пользователя пустой guest_user_id, то должен создасться новый пользователь' do
    assert_difference -> {User.count} do
      get :index
      assert_response :success
    end
    assert_equal session["guest_user_id"], User.last.id
  end
end
