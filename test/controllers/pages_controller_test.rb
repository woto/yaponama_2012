# encoding: utf-8
#
require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test 'Проверка тестовой страницы' do

    assert_generates '/1/1', { controller: 'pages', action: 'show', path: '1/1' }
    assert_generates '1/1', { controller: 'pages', action: 'show', path: '1/1' }

    get :show, :path => '1/1'

    assert_select 'title', 'title'
    assert_select('link[rel="canonical"][href="/1/1"]')
    assert_select('meta[name="description"][content="description"]')
    assert_select('meta[name="keywords"][content="keywords"]')
    assert_select('meta[name="robots"][content="robots"]')
    assert_select '#editable', 'content'

  end

  test 'Провека не существующей страницы' do
    assert_raise ActionController::RoutingError do
      get :show, :path => 'Не существует'
      assert_response :missing
    end
  end

end
