require 'test_helper'

class BrandChainTest < ActionDispatch::IntegrationTest

  test 'Тестируем /catalogs/brands/дочерний_id -> /catalogs/brands/родительский_id' do
    get "/catalogs/brands/#{brands(:child1_synonym).to_param}"
    assert_redirected_to "/catalogs/brands/#{brands(:child1_conglomerate).to_param}"
  end

  test 'Тестируем /brands/дочерний_id -> /brands/родительский_id' do
    get "/brands/#{brands(:child1_synonym).to_param}"
    assert_redirected_to "/brands/#{brands(:child1_child2).to_param}"
  end

  test 'Тестируем /categories/категория/brands/дочерний_id -> /categories/категория/brands/родительский_id' do
    get "/categories/#{spare_catalogs(:akb).to_param}/brands/#{brands(:child1_synonym).to_param}"
    assert_redirected_to "/categories/#{spare_catalogs(:akb).to_param}/brands/#{brands(:child1_conglomerate).to_param}"
  end

end
