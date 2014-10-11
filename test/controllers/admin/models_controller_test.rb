# encoding: utf-8
#
require 'test_helper'

class Admin::ModelsControllerTest < ActionController::TestCase

  test 'Тестируем работу поиска, использующегося в выпадающем списке' do
    first_admin = somebodies(:first_admin)
    cookies['auth_token'] = first_admin.auth_token
    xhr :get, :search, {:format => :json}
    assert_response :success
  end

  # TODO передавать параметр name.
  # TODO, передавать brand_id
  # TODO передавать page
end
