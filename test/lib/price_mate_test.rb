require 'test_helper'

class PriceMateTest < ActiveSupport::TestCase

  test 'PriceMate.search' do
    result = PriceMate.search(Rails.configuration.price['host'], Rails.configuration.price['port'], 'proverka_search', 'ПРОИЗВОДИТ', '0', '0', '0')
    sample = {"result_replacements"=>[{"yield"=>true, "catalog_number"=>"PROVERKASEARCH", "replacements"=>[], "manufacturer"=>"ПРОИЗВОДИТ"}], "result_prices"=>[{"retail_cost_with_discounts"=>743.25, "job_import_job_country_short"=>"Москва", "job_import_job_output_order"=>1, "job_import_job_presence"=>1, "supplier_kpp"=>"", "description"=>"", "external_id"=>nil, "md5"=>"3c", "created_at"=>nil, "supplier_id"=>1, "catalog_number"=>"PROVERKASEARCH", "job_id"=>1, "job_title"=>"Прайс", "applicability"=>"", "income_cost_in_currency_without_weight"=>495.5, "income_cost"=>495.5, "job_import_job_kilo_price"=>0.0, "job_import_job_delivery_summary"=>"Москва", "image_url"=>nil, "bit_original"=>0, "job_import_job_delivery_days_declared"=>1, "delivery_days_declared"=>0, "success_percent"=>55, "unit"=>nil, "price_goodness"=>1.0, "ps_absolute_weight_rate"=>0.0, "ps_relative_weight_rate"=>1.0, "c_weight_value"=>1.0, "job_import_job_country"=>"Москва", "supplier_title"=>"Авториф", "min_order"=>nil, "multiply_factor"=>nil, "manufacturer_orig"=>"ПРОИЗВОДИТЕЛЬ", "retail_cost"=>743.25, "job_import_job_delivery_days_average"=>nil, "supplier_title_full"=>"", "supplier_title_en"=>"", "delivery_days_price"=>nil, "parts_group"=>"", "price_cost"=>"991.0", "ps_relative_buy_rate"=>0.5, "ps_retail_rate"=>"1.5", "ij_income_rate"=>1.0, "currency"=>"1", "supplier_inn"=>"1", "external_supplier_id"=>nil, "updated_at"=>nil, "weight_grams"=>"0", "processed"=>nil, "country"=>nil, "manufacturer"=>"ПРОИЗВОДИТ", "count"=>5, "title"=>"НАЗВАНИЕ", "ps_absolute_buy_rate"=>0.0, "minimal_income_cost"=>nil, "unit_package"=>nil, "catalog_number_orig"=>"proverka_search", "id"=>1, "real_job_id"=>2, "ps_weight_unavailable_rate"=>1.0, "ps_kilo_price"=>0.0, "c_buy_value"=>1.0, "income_cost_in_currency_with_weight"=>495.5, "price_setting_id"=>1, "title_en"=>""}], "result_message"=>"Ок"}
    result['result_prices'][0]['id'] = 1
    assert_equal(sample, result)
  end

  test 'Запрос к неотвечающему серверу прайсов должен raise exception' do
    old = Rails.configuration.price['host']
    Rails.configuration.price['host'] = 'example.com'
    assert_raise Timeout::Error do
      PriceMate.search('example.com', 666, '1', '1', '1', '1', '1')
    end
    Rails.configuration.price['host'] = old
  end

  test 'PriceMate.fill_offer' do
    item = {
      'supplier_title' => 'supplier_title',
      'supplier_title_full' => 'supplier_title_full',
      'price_logo_emex' => 'price_logo_emex',
      'job_title' => 'job_title',
      'supplier_title_en' => 'supplier_title_en',
      'income_cost' => 200.75,
      'job_import_job_country_short' => 'job_import_job_country_short',
      'job_import_job_delivery_days_declared' => 2,
      'job_import_job_delivery_days_average' => 3,
      'success_percent' => 'success_percent',
      'retail_cost' => 300.05,
      'count' => 'count',
      'job_import_job_delivery_summary' => 'job_import_job_delivery_summary',
      'supplier_id' => 'supplier_id',
      'price_setting_id' => 'price_setting_id'}

    offer = {
      :country => "job_import_job_country_short",
      :min_days => 2,
      :max_days => 3,
      :probability => "success_percent",
      :retail_cost => 300,
      :count => 'count',
      :title => '',
      :delivery => "job_import_job_delivery_summary",
      :income_cost => 201,
      :supplier_id => "supplier_id",
      :price_setting_id => "price_setting_id",
      :tech => "supplier_title, supplier_title_full, price_logo_emex, job_title, supplier_title_en, 200.75"
    }

    result = PriceMate.fill_offer(item)

    assert_equal(offer, result)
  end

  test 'PriceMate.clear' do
    result = PriceMate.search(Rails.configuration.price['host'], Rails.configuration.price['port'], 'proverka_search', 'ПРОИЗВОДИТ', '0', '0', '0')
    cleared = PriceMate.clear(result)
    assert_equal({"result_prices"=>[{"retail_cost"=>743.25, "job_import_job_country"=>"Москва", "supplier_title_full"=>"", "description"=>'', "job_title"=>"Прайс", "supplier_title"=>"Авториф", "parts_group"=>'', "catalog_number_orig"=>"proverka_search", "job_import_job_delivery_days_declared"=>1, "weight_grams"=>"0", "title"=>"НАЗВАНИЕ", "job_import_job_delivery_summary"=>"Москва", "country"=>nil, "price_goodness"=>1.0, "income_cost"=>495.5, "applicability"=>'', "catalog_number"=>"PROVERKASEARCH", "job_import_job_country_short"=>"Москва", "supplier_id"=>1, "manufacturer_orig"=>"ПРОИЗВОДИТЕЛЬ", "supplier_title_en"=>"", "delivery_days_declared"=>0, "image_url"=>nil, "success_percent"=>55, "job_import_job_delivery_days_average"=>nil, "delivery_days_price"=>nil, "price_setting_id"=>1, "manufacturer"=>"ПРОИЗВОДИТ", "count"=>5, "title_en"=>''}], "result_replacements"=>[{"catalog_number"=>"PROVERKASEARCH", "yield"=>true, "replacements"=>[], "manufacturer"=>"ПРОИЗВОДИТ"}]}, cleared)
  end

  test 'PriceMate.fill_titles' do
    data = {
      titles: {}
    }
    item = {
      'title' => 'title',
      'title_en' => 'title_en',
      'description' => 'description',
      'applicability' => 'applicability',
      'parts_group' => 'parts_group'
    }

    data[:titles] = PriceMate.fill_titles(data, item)
    assert_equal({
      titles: {
        'TITLE' => 1,
        'TITLE_EN' => 1,
        'DESCRIPTION' => 1,
        'APPLICABILITY' => 1,
        'PARTS_GROUP' => 1
      }}, data)

    data[:titles] = PriceMate.fill_titles(data, item)
    assert_equal({
      titles: {
        'TITLE' => 2,
        'TITLE_EN' => 2,
        'DESCRIPTION' => 2,
        'APPLICABILITY' => 2,
        'PARTS_GROUP' => 2
      }}, data)
  end

  test 'PriceMate.min_days' do
    data = {}

    offer = {min_days: 5}
    data[:min_days] = PriceMate.min_days(data, offer)
    assert_equal 5, data[:min_days]

    offer = {min_days: 3}
    data[:min_days] = PriceMate.min_days(data, offer)
    assert_equal 3, data[:min_days]

    offer = {min_days: 7}
    data[:min_days] = PriceMate.min_days(data, offer)
    assert_equal 3, data[:min_days]
  end

  test 'PriceMate.max_days' do
    data = {}

    offer = {max_days: 3}
    data[:max_days] = PriceMate.max_days(data, offer)
    assert_equal 3, data[:max_days]

    offer = {max_days: 7}
    data[:max_days] = PriceMate.max_days(data, offer)
    assert_equal 7, data[:max_days]

    offer = {max_days: 5}
    data[:max_days] = PriceMate.max_days(data, offer)
    assert_equal 7, data[:max_days]
  end

  test 'PriceMate.min_cost' do
    data = {}

    offer = {retail_cost: 500}
    data[:min_cost] = PriceMate.min_cost(data, offer)
    assert_equal 500, data[:min_cost]

    offer = {retail_cost: 300}
    data[:min_cost] = PriceMate.min_cost(data, offer)
    assert_equal 300, data[:min_cost]

    offer = {retail_cost: 400}
    data[:min_cost] = PriceMate.min_cost(data, offer)
    assert_equal 300, data[:min_cost]
  end

  test 'PriceMate.max_cost' do
    data = {}

    offer = {retail_cost: 300}
    data[:max_cost] = PriceMate.max_cost(data, offer)
    assert_equal 300, data[:max_cost]

    offer = {retail_cost: 500}
    data[:max_cost] = PriceMate.max_cost(data, offer)
    assert_equal 500, data[:max_cost]

    offer = {retail_cost: 400}
    data[:max_cost] = PriceMate.max_cost(data, offer)
    assert_equal 500, data[:max_cost]
  end

  test 'PriceMate.weights' do
    data = {}
    item = {}
    res = PriceMate.weights(data, item)
    assert_equal({}, res)

    item = {'weight_grams' => 100}
    res = PriceMate.weights(data, item)
    assert_equal({0.1 => 1}, res)

    item = {'weight_grams' => 200}
    res = PriceMate.weights(data, item)
    assert_equal({0.1 => 1, 0.2 => 1}, res)

    item = {'weight_grams' => 100}
    res = PriceMate.weights(data, item)
    assert_equal({0.1 => 2, 0.2 => 1}, res)
  end

  test 'PriceMate.manufacturer_origs' do
    data = {}
    item = {}
    brand_name = 'Brand'

    res = PriceMate.manufacturer_origs(data, brand_name, item)
    assert_equal({}, res)

    item = {'manufacturer_orig' => 'Manufacturer 1'}
    res = PriceMate.manufacturer_origs(data, brand_name, item)
    assert_equal({'MANUFACTURER 1' => 1}, res)

    item = {'manufacturer_orig' => 'Brand'}
    res = PriceMate.manufacturer_origs(data, brand_name, item)
    assert_equal({'MANUFACTURER 1' => 1}, res)

    item = {'manufacturer_orig' => 'Manufacturer 2'}
    res = PriceMate.manufacturer_origs(data, brand_name, item)
    assert_equal({'MANUFACTURER 1' => 1, 'MANUFACTURER 2' => 1}, res)

    item = {'manufacturer_orig' => 'Manufacturer 2'}
    res = PriceMate.manufacturer_origs(data, brand_name, item)
    assert_equal({'MANUFACTURER 1' => 1, 'MANUFACTURER 2' => 2}, res)
  end

  test 'PriceMate.catalog_number_origs' do
    data = {}
    item = {}
    catalog_number = '123QWE'

    res = PriceMate.catalog_number_origs(data, catalog_number, item)
    assert_equal({}, res)

    item = {'catalog_number_orig' => '123.qwe'}
    res = PriceMate.catalog_number_origs(data, catalog_number, item)
    assert_equal({'123.QWE' => 1}, res)

    item = {'catalog_number_orig' => '123qwe'}
    res = PriceMate.catalog_number_origs(data, catalog_number, item)
    assert_equal({'123.QWE' => 1}, res)

    item = {'catalog_number_orig' => '123-qwe'}
    res = PriceMate.catalog_number_origs(data, catalog_number, item)
    assert_equal({'123.QWE' => 1, '123-QWE' => 1}, res)

    item = {'catalog_number_orig' => '123-qwe'}
    res = PriceMate.catalog_number_origs(data, catalog_number, item)
    assert_equal({'123.QWE' => 1, '123-QWE' => 2}, res)
  end

  test 'PriceMate.cleanup' do
    data = {
      'Catalog Number 1' => {
        'Brand' => {offers: []}},
      'Catalog Number 2' => {
        'Brand' => {offers: [{}]}}}
    sample = {
      'Catalog Number 2' => {
        'Brand' => {offers: [{}]}}}
    res = PriceMate.cleanup(data)
    assert_equal sample, data
  end

  test 'PriceMate.warehouses' do
    spare_info = spare_infos(:bosh_s4_005_same_number)
    delivery_place = deliveries_places(:first)
    warehouse = warehouses(:bosh_s4_005_same_number)
    data = {
      "S4005" => {
        "Bosch" => {
          info: spare_info
        }
      }
    }
    res = PriceMate.warehouses(data)
    assert_equal({delivery_place.id => warehouse}, res["S4005"]["Bosch"][:warehouses])
  end

end

