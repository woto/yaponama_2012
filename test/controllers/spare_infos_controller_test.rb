require 'test_helper'

class SpareInfosControllerTest < ActionController::TestCase

  test 'Если мы вводим в элемент select2 "21 ni", то должны получить "2102 - nissan"' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    xhr :get, :search, name: '21 ni'
    assert_equal ['2102 (NISSAN)'], assigns(:resources).map(&:name)
  end

end
