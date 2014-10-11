require 'test_helper'

class BrandTest < ActiveSupport::TestCase

  test 'Проверяем отсутсвие возможности указания в качестве родительского бренда себя' do
    brand = brands(:acura)
    brand.brand_id = brands(:acura).id
    refute brand.valid?
  end

  test 'При удалении бренда, который выставлен в качестве родителя других брендов. Другие бренды удаляются' do
    skip
  end

  test 'Связка Синоним -> Производитель, запретить создание дополнительных вложений' do
    skip
  end

end

