# encoding: utf-8

require 'test_helper'

class UploadsControllerTest < ActionController::TestCase

  test 'Заготовка' do
    get :index
    assert_response :success
  end

end

