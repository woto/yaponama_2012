# encoding: utf-8

require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  test 'Аутентифицированный пользователь может выйти' do
    post '/login', { :login => email_addresses(:first_email_address).email_address, :password => '1111111111' }
    assert flash[:notice]

    delete '/logout'
    assert flash[:notice]
  end
end
