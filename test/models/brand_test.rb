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
    br.update(brand: brands(:kia))
    assert_equal "KIA", si.reload.brand.name
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
