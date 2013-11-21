# encoding: utf-8
#
require 'test_helper'

class RoutingConcernsTest < ActionDispatch::IntegrationTest
 test 'first_test' do
    get '/'
    assert_equal '200', @response.code
  end
end

