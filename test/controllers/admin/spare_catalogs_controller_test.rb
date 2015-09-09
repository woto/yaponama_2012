require 'test_helper'

class Admin::SpareCatalogsControllerTest < ActionController::TestCase

  test 'Если мы вводим в элемент select2 "ру тя" то должны получить "РУЛЕВАЯ ТЯГА"' do
    xhr :get, :index, q: {name_matches: '%ру%тя%'}
    assert_equal ['РУЛЕВАЯ ТЯГА'], assigns(:resources).map(&:name)
  end

end
