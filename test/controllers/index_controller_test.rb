# encoding: utf-8

require 'test_helper'

class IndexControllerTest < ActionController::TestCase

  test 'При первом посещении должна создаться учетная запись с ролью guest' do
    cookies["m"] = '1'
    session["y"] = '2'
    assert_difference('User.count') do
      get :index
    end
  end

end
