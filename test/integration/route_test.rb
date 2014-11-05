require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest

  test 'Если заходят в каталог по URL, в котором id бренда привязан как синоним, то происходит редирект на родителя' do
    ms = brands(:ms)
    mitsubishi = brands(:ms).brand
    assert_equal mitsubishi, ms.brand

    get "/catalogs/brands/#{ms.to_param}"
    assert_equal '301', @response.code
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}"

    get "/catalogs/brands/#{ms.to_param}?some"
    assert_equal '301', @response.code
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some"

    get "/catalogs/brands/#{ms.to_param}?some=1"
    assert_equal '301', @response.code
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1"

    get "/catalogs/brands/#{ms.to_param}?some=1&another"
    assert_equal '301', @response.code
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1&another"

    get "/catalogs/brands/#{ms.to_param}?some=1&another=2"
    assert_equal '301', @response.code
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1&another=2"

    get "/catalogs/brands/#{mitsubishi.to_param}"
    assert_equal '200', @response.code
    assert_template "catalogs/brands/show"

 end

end
