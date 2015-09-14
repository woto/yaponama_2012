require 'test_helper'

class BrandTest < ActiveSupport::TestCase

  test 'Проверяем отсутсвие возможности указания в качестве родительского бренда себя' do
    brand = brands(:acura)
    brand.brand_id = brands(:acura).id
    refute brand.valid?
  end

  test 'Проверяем переименование бренда' do
    si = spare_infos(:ki_2103)
    br = si.brand
    assert_equal "KI", br.name
    br.update(name: 'КИА')
    assert_equal "КИА", si.reload.brand.name
  end

  test 'Проверяем выставление родительского бренда' do
    si = spare_infos(:ki_2103)
    br = si.brand
    assert_equal "KI", br.name
    br.update!(brand: brands(:kia), sign: Brand.signs[:synonym], is_brand: false)
    assert_equal "KIA", si.reload.brand.name
  end

  test 'Если заполнен sign: slang, то должен быть и brand' do
    brand = Brand.new(name: 'Brand', sign: Brand.signs[:slang])
    refute brand.valid?
    assert_equal ['В случае когда заполняется родительский бренд или признак принадлежности родительскому бренду, то должен быть заполнен и второй параметр'], brand.errors[:base]
  end

  test 'Если заполнен sign: synonym, то должен быть и brand' do
    brand = Brand.new(name: 'Brand', sign: Brand.signs[:synonym])
    refute brand.valid?
    assert_equal ['В случае когда заполняется родительский бренд или признак принадлежности родительскому бренду, то должен быть заполнен и второй параметр'], brand.errors[:base]
  end

  test 'Если заполнен sign: conglomerate, то должен быть и brand' do
    brand = Brand.new(name: 'Brand', sign: Brand.signs[:conglomerate])
    refute brand.valid?
    assert_equal ['В случае когда заполняется родительский бренд или признак принадлежности родительскому бренду, то должен быть заполнен и второй параметр'], brand.errors[:base]
  end

  test 'Если заполнен brand, то должен быть и sign' do
    brand = Brand.new(name: 'Brand', brand: Brand.new(name: 'Brand'))
    refute brand.valid?
    assert_equal ['В случае когда заполняется родительский бренд или признак принадлежности родительскому бренду, то должен быть заполнен и второй параметр'], brand.errors[:base]
  end

  test 'slang не может быть is_brand' do
    brand = Brand.new(name: 'Brand', is_brand: true, sign: Brand.signs[:slang], brand: Brand.new(name: 'Brand'))
    refute brand.valid?
    assert_equal ['slang не может быть is_brand'], brand.errors[:base]
  end

  test 'synonym не может быть is_brand' do
    brand = Brand.new(name: 'Brand', is_brand: true, sign: Brand.signs[:synonym], brand: Brand.new(name: 'Brand'))
    refute brand.valid?
    assert_equal ['synonym не может быть is_brand'], brand.errors[:base]
  end

  test 'Конгломерат может быть is_brand' do
    brand = Brand.new(name: 'Brand', is_brand: true, sign: Brand.signs[:conglomerate], brand: Brand.new(name: 'Brand'))
    assert brand.valid?
  end

  test 'Производитель без sign может быть is_brand' do
    brand = Brand.new(name: 'Brand', is_brand: true)
    assert brand.valid?
  end

  test 'Проверяем удаление родительского бренда' do
    skip
  end

  test 'При удалении бренда, который выставлен в качестве родителя других брендов. Другие бренды удаляются' do
    skip
  end

  test 'Связка Синоним -> Производитель, запретить создание дополнительных вложений' do
    skip
  end

end
