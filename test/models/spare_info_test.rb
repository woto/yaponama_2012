require 'test_helper'

class SpareInfoTest < ActiveSupport::TestCase

  test 'Категорию можно изменить если не установлен флаг fix_spare_catalog (из Job можно изменить категорию)' do
    si = spare_infos(:ki_2103)
    sc = si.spare_catalog
    si.update(fix_spare_catalog: false)
    si.update(spare_catalog: Defaults.spare_catalog)
    si.reload
    assert_equal Defaults.spare_catalog, si.spare_catalog
  end

  test 'Категорию нельзя изменить если установлен флаг fix_spare_catalog (Из Job нельзя изменить категорию)' do
    si = spare_infos(:ki_2103)
    sc = si.spare_catalog
    si.update(fix_spare_catalog: true)
    si.update(spare_catalog: Defaults.spare_catalog)
    si.reload
    assert_equal sc, si.spare_catalog 
  end

  test 'Категорию можно изменить если установлен флаг fix_spare_catalog и отправлен флаг change_spare_catalog (Ручное изменение категории)' do
    si = spare_infos(:ki_2103)
    sc = si.spare_catalog
    si.update(fix_spare_catalog: true)
    si.update(change_spare_catalog: true, spare_catalog: Defaults.spare_catalog)
    si.reload
    assert_equal Defaults.spare_catalog, si.spare_catalog
  end

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

  test 'Валидный объект SpareInfo с 1-м SpareInfoPhrase, который является primary' do
    si = SpareInfo.new(spare_catalog: Defaults.spare_catalog, catalog_number: '23828-99232-238', brand: Defaults.brand)
    si.spare_info_phrases.new(catalog_number: '23948-23829-12384938', primary: true)
    assert si.valid?
  end

  test 'Тестируем присвоение правильных и не правильных брендов' do
    si = SpareInfo.new(spare_catalog: Defaults.spare_catalog, catalog_number: '23948-23829-12384938', brand: Defaults.brand)
    si.spare_info_phrases.new(catalog_number: '23948-23829-12384938', primary: true)

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

  test 'Нельзя чтобы у объекта было два SpareInfoPhrase и оба primary' do
    si = SpareInfo.new(catalog_number: '123', brand: Defaults.brand, spare_catalog: Defaults.spare_catalog)
    si.spare_info_phrases.new(catalog_number: '123', primary: true)
    assert si.valid?
    si.spare_info_phrases.new(catalog_number: '123', primary: true)
    refute si.valid?
  end

  test 'Можно чтобы у объекта было два SpareInfoPhrase один из которых primary' do
    si = SpareInfo.new(catalog_number: '123', brand: Defaults.brand, spare_catalog: Defaults.spare_catalog)
    si.spare_info_phrases.new(catalog_number: '123', primary: true)
    assert si.valid?
    si.spare_info_phrases.new(catalog_number: '123', primary: false)
    assert si.valid?
  end

  test 'Удаляя SpareInfo мы так же должны автоматом удалить SpareInfoPhrase' do
    si = spare_infos(:spare_info_phrases_destroy_test)
    assert_equal 2, si.spare_info_phrases.count
    assert_difference -> {SpareInfoPhrase.count}, -2 do
      si.destroy
    end
  end

  test 'Не допустимо чтобы у объекта был бренд, с заполненным sign' do
    invalid_brand = brands(:child1_synonym)
    valid_brand = brands(:child1_child2)

    si = SpareInfo.new(catalog_number: '123', brand: invalid_brand, spare_catalog: Defaults.spare_catalog)
    si.spare_info_phrases.new(catalog_number: '123', primary: true)

    refute si.valid?
    assert si.errors[:brand].any?

    si.brand = valid_brand
    assert si.valid?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный Accumulator' do
    si = spare_infos(:accumulator_destroy_test)
    si.destroy
    assert si.persisted?
    si.accumulator.destroy
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный TruckTire' do
    si = spare_infos(:truck_tire_destroy_test)
    si.destroy
    assert si.persisted?
    si.truck_tire.destroy
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный Warehouse' do
    si = spare_infos(:warehouse_destroy_test)
    si.destroy
    assert si.persisted?
    si.warehouses.destroy_all
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный from_spare_replacements' do
    si = spare_infos(:from_spare_replacements_destroy_test)
    si.destroy
    assert si.persisted?
    si.from_spare_replacements.destroy_all
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный to_spare_replacements' do
    si = spare_infos(:to_spare_replacements_destroy_test)
    si.destroy
    assert si.persisted?
    si.to_spare_replacements.destroy_all
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть связанный spare_applicabilities' do
    si = spare_infos(:applicabilities_destroy_test)
    si.destroy
    assert si.persisted?
    si.spare_applicabilities.destroy_all
    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть хотя бы одна картинка. Проверяем только первую' do
    extend ActionDispatch::TestProcess
    si = spare_infos(:destroy_test)
    si.spare_info_phrases.new(catalog_number: 'destroy_test', primary: true)
    si.image1 = fixture_file_upload('rails.png','image/png')
    si.save!

    assert si.persisted?
    si.destroy

    assert si.persisted?
    si.reload.remove_image1!

    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть хотя бы один файл. Проверяем только восьмой' do
    extend ActionDispatch::TestProcess
    si = spare_infos(:destroy_test)
    si.spare_info_phrases.new(catalog_number: 'destroy_test', primary: true)
    si.file8 = fixture_file_upload('rails.png','image/png')
    si.save!

    assert si.persisted?
    si.destroy

    assert si.persisted?
    si.reload.remove_file8!

    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалить SpareInfo, если у него есть content' do
    si = spare_infos(:content_destroy_test)
    si.destroy

    assert si.persisted?
    si.reload.update!(content: '')

    si.reload.destroy
    refute si.persisted?
  end

  test 'Мы не можем удалть SpareInfo, если у него есть hstore' do
    si = spare_infos(:hstore_destroy_test)
    si.destroy

    assert si.persisted?
    si.reload.update!(hstore: {})

    si.reload.destroy
    refute si.persisted?
  end

  test 'После сохранения SpareInfo у нас заполняется name. Пока что нужно для использования в заменах, применимостях и т.д.' do
    si = SpareInfo.new(catalog_number: '123', spare_catalog: Defaults.spare_catalog, brand: Defaults.brand, spare_info_phrases: [SpareInfoPhrase.new({catalog_number: '123', primary: true})])
    si.save!
    assert_equal '123 (ОРИГИНАЛ)', si.name
  end

end
