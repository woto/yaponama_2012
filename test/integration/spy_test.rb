# encoding: utf-8

require 'test_helper'

class SpyTest < ActionDispatch::IntegrationTest

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

  test 'Если на стороне клиента установлено неверное время, то ошибки произойти не должно, а будет установлен часовой пояс по-умолчанию. Если клиент изменит время на своем компьютере на верное, напр. +3 часа (плюс минус погрешности в минутах), то соответсвенно у него должен выставиться часовой пояс +3' do

    post '/stats', {
      russian_time_zone_auto: Time.now - 1.year,
      stat: {
        location: '' ,
        title:  '',
        referrer: '',
      }
    }

    assert_equal User.last.russian_time_zone_auto_id, 4

    post '/stats', {
      russian_time_zone_auto: Time.now + 3.hours + 10.minutes,
      stat: {
        location: '' ,
        title:  '',
        referrer: '',
      }
    }

    assert_equal User.last.russian_time_zone_auto_id, 3
  end

  test 'Мы должны запоминать переданные клиентом user_agent и accept_language как есть. Аналогично как и с ip, если эти аттрибуты меняются, то мы так же сохраняем новые значения' do
    get '/', {}, { 'User-Agent' => 'Browser 1', 'Accept-Language' => 'Language 1' }
    assert_equal User.last.user_agent, 'Browser 1'
    assert_equal User.last.accept_language, 'Language 1'

    get '/', {}, { 'User-Agent' => 'Browser 2', 'Accept-Language' => 'Language 2' }
    assert_equal User.last.user_agent, 'Browser 2'
    assert_equal User.last.accept_language, 'Language 2'
  end

  test "Проверяем правильность отправки и сохранения статистики посещенной страницы" do
    # Посещаем страницу товаров
    visit '/user/products'

    # Ждем пока в #stat-result появятся данные
    page.assert_selector '#stat-result.complete', visible: false

    # Проверяем, что запись принадлежит пользователю, который посетил
    assert User.last == Stat.last.user

    # Проверяем, что местонахождения пользователя в статистике записалось правильно
    assert Stat.last.location.include? "products"

    # Находим ссылку на главную
    page.find('.brand').click

    # Убеждаемся, что мы действительно посетили другую страницу
    page.assert_selector '#stat-result.incomplete', visible: false

    # Ждем пока в #stat-result появятся данные
    page.assert_selector '#stat-result.complete', visible: false

    # Проверяем, что предыдущая страница (referrer) записалась правильно
    assert Stat.last.referrer.include? "products"
  end

end
