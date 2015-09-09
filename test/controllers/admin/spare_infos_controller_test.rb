require 'test_helper'

class Admin::SpareInfosControllerTest < ActionController::TestCase

  test 'Успешное создание SpareInfo, с имеющимся брендом и категорией' do
    assert_difference -> {SpareInfo.count} do
      assert_difference [ -> {Brand.count}, -> {SpareCatalog.count}], 0 do
          post :create, {spare_info: {
          catalog_number: '1234567890',
          brand_attributes: { name: "AUDI" },
          spare_catalog_attributes: { name: "САЙЛЕНТБЛОК" },
          spare_info_phrases_attributes: {"0" => {catalog_number: "1234567890", primary: '1'}}}}
      end
    end
    assert assigns(:resource).valid?
  end

  test 'Успешное создание SpareInfo, попутно создавая Brand' do
    assert_difference [-> {SpareInfo.count}, -> {Brand.count}] do
      assert_difference [ -> {SpareCatalog.count}], 0 do
          post :create, {spare_info: {
          catalog_number: '1234567890',
          brand_attributes: { name: "New Brand" },
          spare_catalog_attributes: { name: "САЙЛЕНТБЛОК" },
          spare_info_phrases_attributes: {"0" => {catalog_number: "1234567890", primary: '1'}}}}
      end
    end
    assert assigns(:resource).valid?
  end

  test 'Успешное создание SpareInfo, попутно создавая SpareCatalog' do
    assert_difference [-> {SpareInfo.count}, -> {SpareCatalog.count}] do
      assert_difference [ -> {Brand.count}], 0 do
          post :create, {spare_info: {
          catalog_number: '1234567890',
          brand_attributes: { name: "AUDI" },
          spare_catalog_attributes: { name: "New Spare Catalog" },
          spare_info_phrases_attributes: {"0" => {catalog_number: "1234567890", primary: '1'}}}}
      end
    end
    assert assigns(:resource).valid?
  end

  test 'Если мы не указали бренд, то должны увидеть ошибку' do
    post :create, {spare_info: {
    catalog_number: '1234567890',
    brand_attributes: { name: "" }}}
    assert assigns(:resource).errors["brand.name"]
  end

  test 'Если мы не указали категорию, то должны увидеть ошибку' do
    post :create, {spare_info: {
    catalog_number: '1234567890',
    spare_catalog_attributes: { name: "" }}}
    assert assigns(:resource).errors["spare_catalog.name"]
  end

  test 'Если мы отправили change_spare_catalog, то категория изменится' do
    put :update, {spare_info: {
      spare_catalog_attributes: {
        name: "New spare catalog"
      },
      change_spare_catalog: '1' },
      id: spare_infos(:toyota_3310)}
    spare_catalog = SpareCatalog.last
    assert_equal spare_catalog, spare_infos(:toyota_3310).reload.spare_catalog
  end

  test 'Если мы не отправили change_spare_catalog, и у товара не зафиксирована категория, то категория изменится' do
    put :update, {spare_info: {
      spare_catalog_attributes: {
        name: "New spare catalog"
      }},
      id: spare_infos(:toyota_3310)}
    spare_catalog = SpareCatalog.last
    assert_equal spare_catalog, spare_infos(:toyota_3310).reload.spare_catalog
  end

  test 'Если мы не отправили change_spare_catalog, и у товара зафиксирована категория, то категория не изменится' do
    put :update, {spare_info: {
      spare_catalog_attributes: {
        name: "New spare catalog"
      }},
      id: spare_infos(:fix_spare_catalog)}
    spare_catalog = spare_catalogs(:rulevaya_tyga)
    assert_equal spare_catalog, spare_infos(:toyota_3310).reload.spare_catalog
  end

end
