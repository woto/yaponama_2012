require 'test_helper'

class Admin::BrandsControllerTest < ActionController::TestCase


  test 'Проверяем смену spare_infos при присвоении производителю KI родительского производителя KIA' do

    assert_equal "KI", spare_infos(:ki_2103).brand.name
    assert_equal "KI", spare_infos(:ki_2102).brand.name
    assert_equal nil, brands(:ki).brand

    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update,
      "brand" => {
        "sign"=> "synonym",
        "name"=>"KI",
        "brand_attributes" => {
          "name"=>"KIA"
        }
      }, "id" => brands(:ki)

    # Проверяем присвоение родителя
    assert_equal "KIA", brands(:ki).reload.brand.name

    # Проверяем смену spare_infos
    assert_equal "KIA", spare_infos(:ki_2103).reload.brand.name
    assert_equal "KI", spare_infos(:ki_2102).reload.brand.name
  end

  test 'Проверяем смену from_spare_replacements при присвоении производителю KI родительского производителя KIA' do

    assert_equal nil, brands(:ki).brand
    assert_equal "2103 (KI)", spare_replacements(:ki_2103_ns_3310).from_spare_info.to_label

    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update,
      "brand" => {
        "sign"=> "synonym",
        "brand_attributes" => {
          "name"=>"KIA"
        }
      }, "id" => brands(:ki)

    # Проверяем присвоение родителя
    assert_equal brands(:kia), brands(:ki).reload.brand

    # Проверяем смену from_spare_replacements

    assert_equal "2103 (KIA)", spare_replacements(:ki_2103_ns_3310).reload.from_spare_info.to_label
  end

  test 'Проверяем смену to_spare_replacements при присвоении производителю NS родительского производителя NISSAN' do

    assert_equal nil, brands(:ns).brand
    assert_equal "3310 (NS)", spare_replacements(:ki_2103_ns_3310).to_spare_info.to_label

    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update,
      "brand" => {
        "sign"=> "synonym",
        "brand_attributes" => {
          "name"=>"NISSAN"
        }
      }, "id" => brands(:ns)

    # Проверяем присвоение родителя
    assert_equal "NISSAN", brands(:ns).reload.brand.name

    # Проверяем смену to_spare_replacements
    assert_equal "3310 (NISSAN)", spare_replacements(:ki_2103_ns_3310).reload.to_spare_info.to_label
  end

  test 'Проверяем смену spare_applicabilities при присвоении производителю KI родительского производителя KIA' do

    assert_equal "KI", spare_infos(:ki_2103).brand.name
    assert_equal "KI", spare_infos(:ki_2102).brand.name
    assert_equal nil, brands(:ki).brand
    assert_equal "2103 (KI)", spare_applicabilities(:sa_16).spare_info.to_label

    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update,
      "brand" => {
        "sign"=> "synonym",
        "name"=>"KI",
        "brand_attributes" => {
          "name"=>"KIA"
        }
      }, "id" => brands(:ki)

    # Проверяем присвоение родителя
    assert_equal "KIA", brands(:ki).reload.brand.name

    # Проверяем смену spare_applicabilities
    assert_equal "2103 (KIA)", spare_applicabilities(:sa_16).reload.spare_info.to_label
  end

end
