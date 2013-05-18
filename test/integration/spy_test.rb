# encoding: utf-8

require 'test_helper'

class SpyTest < ActionDispatch::IntegrationTest

  test 'При первом посещении должно вырасти количество пользователей в системе.' do
    assert_difference('User.count') do
      get '/'
    end
  end

  test 'Если у клиента указано неправильное время, то не должно произойти ошибки и будет использоваться часовой пояс по-умолчанию' do
    post '/stats', {
      russian_time_zone_auto: Time.now - 1.year,
      stat: {
        location: '' ,
        title:  '',
        referrer: '',
      }
    }

    get '/'
    assert_equal '200', @response.code

  end

end
