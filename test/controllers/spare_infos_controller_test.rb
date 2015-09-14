require 'test_helper'

class SpareInfosControllerTest < ActionController::TestCase

  test 'Если мы вводим в элемент select2 "21", то должны получить предложения' do
    xhr :get, :search, q: { catalog_number_cont: '21' }
    assert_equal ["2102 (KIA)", "2102 (NISSAN)", "2103 (KI)", "2103 (MS)", "2102 (KI)"].sort, assigns(:spare_infos).map(&:name).sort
  end

end
