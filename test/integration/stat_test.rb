require 'test_helper'

class StatTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Сначала мы сэмулируем заход пользователя с ip адресом 85.117.95.1 и обнаружим, что пользователь с Норильска, запишем ip, город и регион, а потом зайдем с 127.0.0.1 запишем новый ip, а город и регион обнулятся' do
    get '/', {}, { 'REMOTE_ADDR' => '85.117.95.1' }
    assert_equal User.last.remote_ip, '85.117.95.1'
    assert_equal User.last.ipgeobase_name, 'Норильск'
    assert_equal User.last.ipgeobase_names_depth_cache, 'Россия/Сибирский федеральный округ/Красноярский край'

    get '/', {}, { 'REMOTE_ADDR' => '127.0.0.1' }
    assert_equal User.last.remote_ip, '127.0.0.1'
    assert_equal User.last.ipgeobase_name, ''
    assert_equal User.last.ipgeobase_names_depth_cache, ''
  end

  test 'Мы должны запоминать переданные клиентом user_agent и accept_language как есть. Аналогично как и с ip, если эти аттрибуты меняются, то мы так же сохраняем новые значения' do
    get '/', {}, { 'User-Agent' => 'Browser 1', 'Accept-Language' => 'Language 1' }
    assert_equal User.last.user_agent, 'Browser 1'
    assert_equal User.last.accept_language, 'Language 1'

    get '/', {}, { 'User-Agent' => 'Browser 2', 'Accept-Language' => 'Language 2' }
    assert_equal User.last.user_agent, 'Browser 2'
    assert_equal User.last.accept_language, 'Language 2'
  end

end
