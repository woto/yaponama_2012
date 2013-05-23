# encoding: utf-8

require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  test 'Аутентифицированный пользователь может выйти' do
    authenticated_as('1111111111', '1111111111') do |administrator|
      #debugger
      get '/admin/users'
      assert_response 200
    end
  end

end
