require 'test_helper'

class PriceMateTest < ActionController::TestCase
  test 'Сверяем ответы search 1' do
    result = PriceMate.search(Rails.configuration.price['host'], Rails.configuration.price['port'], 'proverka_search', 'ПРОИЗВОДИТ', '0', '0', '0')
    assert_equal({"result_prices"=>[{"ps_absolute_weight_rate"=>0.0, "ps_absolute_buy_rate"=>0.0, "retail_cost"=>743.25, "job_import_job_output_order"=>nil, "unit"=>nil, "income_cost_in_currency_with_weight"=>495.5, "job_import_job_country"=>"Москва", "supplier_inn"=>"Авториф", "supplier_title_full"=>"", "description"=>nil, "md5"=>"3c", "ps_kilo_price"=>0.0, "job_import_job_presence"=>1, "job_title"=>"Прайс", "supplier_title"=>"Авториф", "parts_group"=>nil, "catalog_number_orig"=>"proverka_search", "ps_relative_buy_rate"=>0.5, "ij_income_rate"=>1.0, "currency"=>"1", "job_import_job_delivery_days_declared"=>1, "multiply_factor"=>nil, "weight_grams"=>"0", "title"=>"НАЗВАНИЕ", "id"=>6, "retail_cost_with_discounts"=>495.5, "job_import_job_delivery_summary"=>"Москва", "supplier_kpp"=>"", "created_at"=>nil, "country"=>nil, "price_goodness"=>1.0, "ps_weight_unavailable_rate"=>1.0, "c_weight_value"=>1.0, "income_cost"=>495.5, "updated_at"=>nil, "applicability"=>nil, "processed"=>nil, "catalog_number"=>"PROVERKASEARCH", "job_id"=>1, "job_import_job_country_short"=>"Москва", "minimal_income_cost"=>nil, "supplier_id"=>1, "manufacturer_orig"=>"ПРОИЗВОДИТЕЛЬ", "ps_relative_weight_rate"=>1.0, "supplier_title_en"=>"", "delivery_days_declared"=>0, "image_url"=>nil, "success_percent"=>55, "job_import_job_kilo_price"=>0.0, "job_import_job_delivery_days_average"=>nil, "unit_package"=>nil, "delivery_days_price"=>nil, "bit_original"=>0, "price_setting_id"=>1, "manufacturer"=>"ПРОИЗВОДИТ", "count"=>5, "real_job_id"=>2, "ps_retail_rate"=>"1.5", "c_buy_value"=>1.0, "income_cost_in_currency_without_weight"=>495.5, "external_supplier_id"=>nil, "min_order"=>nil, "external_id"=>nil, "price_cost"=>"991.0", "title_en"=>nil}], "result_replacements"=>[{"catalog_number"=>"PROVERKASEARCH", "yield"=>true, "replacements"=>[], "manufacturer"=>"ПРОИЗВОДИТ"}], "result_message"=>"Ок"}, result)
  end

  test 'Запрос к неотвечающему серверу прайсов должен raise exception' do
    old = Rails.configuration.price['host']
    Rails.configuration.price['host'] = 'example.com'
    assert_raise Timeout::Error do
      PriceMate.search('example.com', 666, '1', '1', '1', '1', '1')
    end
    Rails.configuration.price['host'] = old
  end

  test 'Проверяем PriceMate.prepare_structure передавая пустой хеш' do
    hash = {}
    result = PriceMate.prepare_structure('1', Defaults.brand, hash)
    assert_equal(
      {"1"=>
        {"ОРИГИНАЛ"=>
          {:titles=>{},
           :manufacturer_origs=>{},
           :catalog_number_origs=>{},
           :weights=>{},
           :min_days=>nil,
           :max_days=>nil,
           :min_cost=>nil,
           :max_cost=>nil,
           :offers=>[],
           :brand=> Defaults.brand}}},
      result)
  end

  test 'Проверяем PriceMate.prepare_structure с уже заполненным хешем с другим артикулом' do
    hash = {'эмуляция другого артикула' => { 'эмуляция другого производителя' => {}}}
    result = PriceMate.prepare_structure('1', Defaults.brand, hash)
    assert_equal(
      {'эмуляция другого артикула' => { 'эмуляция другого производителя' => {}},
      "1"=>
        {"ОРИГИНАЛ"=>
          {:titles=>{},
           :manufacturer_origs=>{},
           :catalog_number_origs=>{},
           :weights=>{},
           :min_days=>nil,
           :max_days=>nil,
           :min_cost=>nil,
           :max_cost=>nil,
           :offers=>[],
           :brand=> Defaults.brand}}},
      result)
  end

  test 'Проверяем PriceMate.prepare_structure с уже заполненным таким же артикулом и производителем' do
    hash = {'1' => { 'ОРИГИНАЛ' => {}}}
    result = PriceMate.prepare_structure('1', Defaults.brand, hash)
    assert_equal(
      {'1' => { 'ОРИГИНАЛ' => {}}},
      result)
  end

  test 'Проверяем PriceMate.prepare_structure с уже заполненным таким же артикулом, но другим производителем' do
    hash = {'1' => { 'эмуляция другого производителя' => {}}}
    result = PriceMate.prepare_structure('1', Defaults.brand, hash)
    assert_equal(
      {"1"=> {
        'эмуляция другого производителя' => {},
        "ОРИГИНАЛ"=>
          {:titles=>{},
           :manufacturer_origs=>{},
           :catalog_number_origs=>{},
           :weights=>{},
           :min_days=>nil,
           :max_days=>nil,
           :min_cost=>nil,
           :max_cost=>nil,
           :offers=>[],
           :brand=> Defaults.brand}}},
      result)
  end

end
