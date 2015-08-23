require 'test_helper'

class PriceMateTest < ActiveSupport::TestCase

  test 'Категория у товара должна определиться как БАМПЕР ЗАДНИЙ' do
    assert_equal spare_catalogs(:bamper_zadniy), PriceMate.find_a_category('БАМПЕР')
  end

  test 'Категория у товара должна определиться как БАМПЕР или БАМПЕР ЗАДНИЙ в зависимости от веса токенов' do
    token = SpareCatalogToken.create!(name: '%БАМПЕР%', weight: 3)
    category = SpareCatalog.create!(name: ' БАМПЕР ', spare_catalog_tokens: [token])
    assert_equal category, PriceMate.find_a_category('//БАМПЕР, ЗАДНИЙ')

    category.spare_catalog_tokens << SpareCatalogToken.create!(name: '%ЗАДНИЙ%', weight: -2)
    assert_equal spare_catalogs(:bamper_zadniy), PriceMate.find_a_category('//БАМПЕР, ЗАДНИЙ')
  end

  test 'Если категорию определить не удалось, то получаем дефолтную' do
    assert_equal Defaults.spare_catalog, PriceMate.find_a_category('!@#')
  end

end
