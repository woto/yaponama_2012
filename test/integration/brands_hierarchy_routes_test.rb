require 'test_helper'

class BrandsHierarchyroutesTest < ActionDispatch::IntegrationTest
  def setup
    @child1_conglomerate = brands(:child1_conglomerate)
    @child1_synonym = brands(:child1_synonym)
    @child2_conglomerate = brands(:child2_conglomerate)
    @child1_child2 = brands(:child1_child2)
    @shatun = spare_catalogs(:shatun)
  end

  test 'В каталогах. Если мы синоним, то мы ДОДЖНЫ редиректнуться до первого конгломерата или последнего по цепочке' do
    get "/catalogs/brands/#{@child1_synonym.to_param}"
    assert_redirected_to catalogs_brand_path @child1_conglomerate
  end

  test 'В категориях. Если мы синоним, то мы ДОДЖНЫ редиректнуться до первого конгломерата или последнего по цепочке' do
    get "/categories/#{@shatun.to_param}/brands/#{@child1_synonym.to_param}"
    assert_redirected_to category_brand_path(@shatun, @child1_conglomerate)
  end

  test 'В каталогах. Если мы конгломерат, то мы НЕ ДОЛЖНЫ редиректнуться выше' do
    get "/catalogs/brands/#{@child1_conglomerate.to_param}"
    assert_response 200
  end

  test 'В категориях. Если мы конгломерат, то мы НЕ ДОЛЖНЫ редиректнуться выше' do
    get "/categories/#{@shatun.to_param}/brands/#{@child1_conglomerate.to_param}"
    assert_response 200
  end

  test 'В брендах. Мы должны подняться по цепочке брендов максимально возможно (child1 (синоним) -> child1 (конгломерат) -> child1_child2)' do
    get "/brands/#{@child1_synonym.to_param}"
    assert_redirected_to brand_path(@child1_child2)
  end

  test 'В брендах. Мы должны подняться по цепочке брендов максимально возможно (child1 (child1 (конгломерат) -> child1_child2)' do
    get "/brands/#{@child1_conglomerate.to_param}"
    assert_redirected_to brand_path(@child1_child2)
  end

end
