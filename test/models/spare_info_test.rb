require 'test_helper'

class SpareInfoTest < ActiveSupport::TestCase

  test 'Проверяем изменение каталожника + производителя товара через аттрибуты. Замены и применимость должны обновиться' do
    si = spare_infos(:ki_2103)
    assert_equal 'KI', si.brand.name
    assert_equal '2103', si.catalog_number
    assert_equal '2103 (KI)', si.name
    assert_equal '2103 (KI)', spare_applicabilities(:sa_16).cached_spare_info
    assert_equal '2103 (KI)', spare_replacements(:ki_2103_ns_3310).from_cached_spare_info
    assert_equal '2103 (KI)', spare_replacements(:ns_3310_ki_2103).to_cached_spare_info


    si.assign_attributes({
      "catalog_number" => "02103",
      "brand_attributes" => {
        "name"=>"КИА"
      }
    })

    si.save
    spare_applicabilities(:sa_16).reload
    spare_replacements(:ki_2103_ns_3310).reload
    spare_replacements(:ns_3310_ki_2103).reload

    assert_equal "КИА", si.brand.name
    assert_equal '02103', si.catalog_number
    assert_equal '02103 (КИА)', si.name
    assert_equal '02103 (КИА)', spare_applicabilities(:sa_16).cached_spare_info
    assert_equal '02103 (КИА)', spare_replacements(:ki_2103_ns_3310).from_cached_spare_info
    assert_equal '02103 (КИА)', spare_replacements(:ns_3310_ki_2103).to_cached_spare_info

  end

end
