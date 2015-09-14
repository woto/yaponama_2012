require 'test_helper'

class SpareCatalogsControllerTest < ActionController::TestCase

  test 'Если мы вводим в элемент select2 "рулевая" то должны получить "РУЛЕВАЯ ТЯГА"' do
    xhr :get, :search, q: {name_cont: 'рулевая'}
    assert_equal ['РУЛЕВАЯ ТЯГА'], assigns(:spare_catalogs).map(&:name)
  end

end
