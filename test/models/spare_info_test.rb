require 'test_helper'

class SpareInfoTest < ActiveSupport::TestCase

  test 'Проверяем изменение каталожника + производителя товара через аттрибуты. Замены и применимость должны обновиться' do
    si = spare_infos(:ki_2103)
    assert_equal 'KI', si.brand.name
    assert_equal '2103', si.catalog_number
    assert_equal '2103 (KI)', si.name
    assert_equal '2103 (KI)', spare_applicabilities(:sa_16).spare_info.to_label
    assert_equal '2103 (KI)', spare_replacements(:ki_2103_ns_3310).from_spare_info.to_label
    assert_equal '2103 (KI)', spare_replacements(:ns_3310_ki_2103).to_spare_info.to_label


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
    assert_equal '02103 (КИА)', spare_applicabilities(:sa_16).spare_info.to_label
    assert_equal '02103 (КИА)', spare_replacements(:ki_2103_ns_3310).from_spare_info.to_label
    assert_equal '02103 (КИА)', spare_replacements(:ns_3310_ki_2103).to_spare_info.to_label

  end

  test 'Тестируем присвоение правильных и не правильных брендов' do
    si = SpareInfo.new(spare_catalog: Defaults.spare_catalog, catalog_number: '23948-23829-12384938', brand: Defaults.brand)
    assert si.valid?

    si.brand = brands(:child1_synonym)
    refute si.valid?
    assert si.errors[:brand].any?

    si.brand = brands(:child1_conglomerate)
    refute si.valid?
    assert si.errors[:brand].any?

    si.brand = brands(:child2_conglomerate)
    refute si.valid?
    assert si.errors[:brand].any?

    si.brand = brands(:child1_child2)
    assert si.valid?
    refute si.errors[:brand].any?
  end

  test 'Не допустимо чтобы у объекта был бренд, с заполненным sign' do
    invalid_brand = brands(:child1_synonym)
    valid_brand = brands(:child1_child2)

    si = SpareInfo.new(catalog_number: '123', brand: invalid_brand, spare_catalog: Defaults.spare_catalog)
    refute si.valid?
    assert si.errors[:brand].any?

    si.brand = valid_brand
    assert si.valid?
  end

end
