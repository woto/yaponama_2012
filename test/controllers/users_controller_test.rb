# encoding: utf-8

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'visit' do
    get :edit
    assert_response :success
    print cookies
    print session
  end

end
