require 'test_helper'

class RoutingConcernsTest < ActionDispatch::IntegrationTest
 test 'first_test' do
    get '/'
    assert_equal '200', @response.code
  end

 test 'register' do
   get '/register'
   assert_equal '200', @response.code
 end

 test 'login' do
   get '/login'
   assert_equal '200', @response.code
 end

 test 'admin-login' do
   get '/admin/login'
   assert_equal '200', @response.code
 end

end

