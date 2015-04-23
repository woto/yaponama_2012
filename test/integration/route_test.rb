require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest

  test 'Редирект с списка моделей в разрезе бренда' do

    ms = brands(:ms)
    mitsubishi = brands(:mitsubishi)
    assert_equal mitsubishi, ms.brand

    get "/catalogs/brands/#{ms.to_param}"
    assert_response 301
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}"

    get "/catalogs/brands/#{ms.to_param}?some"
    assert_response 301
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some"

    get "/catalogs/brands/#{ms.to_param}?some=1"
    assert_response 301
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1"

    get "/catalogs/brands/#{ms.to_param}?some=1&another"
    assert_response 301
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1&another"

    get "/catalogs/brands/#{ms.to_param}?some=1&another=2"
    assert_response 301
    assert_redirected_to "/catalogs/brands/#{mitsubishi.to_param}?some=1&another=2"

    get "/catalogs/brands/#{mitsubishi.to_param}"
    assert_response 200
    assert_template "catalogs/brands/show"
 end

  test 'Редирект с списка запчастей' do

    ms = brands(:ms)
    mitsubishi = brands(:mitsubishi)
    assert_equal mitsubishi, ms.brand

    get "/brands/#{ms.to_param}/parts"
    assert_response 301
    assert_redirected_to "/brands/#{mitsubishi.to_param}"

    get "/brands/#{ms.to_param}/parts?some=1"
    assert_response 301
    assert_redirected_to "/brands/#{mitsubishi.to_param}"

    get "/brands/#{mitsubishi.to_param}"
    assert_response 200
    assert_template "brands/show"

  end

  test 'Редирект с списка моделей в разрезе категории' do

    bamper_zadniy = spare_catalogs(:bamper_zadniy)
    ms = brands(:ms)
    mitsubishi = brands(:mitsubishi)
    assert_equal mitsubishi, ms.brand

    get "/categories/#{bamper_zadniy.to_param}/brands/#{ms.to_param}"
    assert_response 301
    assert_redirected_to "/categories/#{bamper_zadniy.to_param}/brands/#{mitsubishi.to_param}"

    get "/categories/#{bamper_zadniy.to_param}/brands/#{ms.to_param}?some=1"
    assert_response 301
    assert_redirected_to "/categories/#{bamper_zadniy.to_param}/brands/#{mitsubishi.to_param}?some=1"

    get "/categories/#{bamper_zadniy.to_param}/brands/#{mitsubishi.to_param}"
    assert_response 200
    assert_template "categories/brands/show"

    get "/categories/#{bamper_zadniy.to_param}/brands/#{mitsubishi.to_param}?some=1"
    assert_response 200
    assert_template "categories/brands/show"
  end

end
