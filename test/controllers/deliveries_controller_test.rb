require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase

  test 'Если я с Москвы, то мне показывается по-умолчанию вкладка Москва' do
    @request.remote_addr = '176.195.87.131'
    get :index
    assert_select '#moscow-link.active'
    assert_select '#moscow-tab.active'
    assert_select '#russia-link:not(.active)'
    assert_select '#russia-tab:not(.active)'
  end

  test 'Если я с Норильска, то мне показывается по-умолчанию вкладка Россия' do
    @request.remote_addr = '85.117.95.1'
    get :index
    assert_select '#russia-link.active'
    assert_select '#russia-tab.active'
    assert_select '#moscow-link:not(.active)'
    assert_select '#moscow-tab:not(.active)'
  end

end
