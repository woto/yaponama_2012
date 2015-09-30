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
    assert_equal ['slang или synonym не может быть is_brand'], brand.errors[:base]
  end

  test 'synonym не может быть is_brand' do
    brand = Brand.new(name: 'Brand', is_brand: true, sign: Brand.signs[:synonym], brand: Brand.new(name: 'Brand'))
    refute brand.valid?
    assert_equal ['slang или synonym не может быть is_brand'], brand.errors[:base]
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

  test 'у synonym нельзя указывать в качестве родителя бренд, у которого выставлен synonym' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:synonym], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:synonym], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у slang нельзя указывать в качестве родителя бренд, у которого выставлен synonym' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:synonym], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:slang], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у conglomerate нельзя указывать в качестве родителя бренд, у которого выставлен synonym' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:synonym], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:conglomerate], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у synonym нельзя указывать в качестве родителя бренд, у которого выставлен slang' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:slang], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:synonym], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у slang нельзя указывать в качестве родителя бренд, у которого выставлен slang' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:slang], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:slang], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у conglomerate нельзя указывать в качестве родителя бренд, у которого выставлен slang' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:slang], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:conglomerate], brand: brand2)
    refute brand3.persisted?
    assert_equal ["В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym"], brand3.errors[:base]
  end

  test 'у conglomerate нельзя указывать в качестве родителя бренд, у которого так же выставлен conglomerate' do
    brand1 = Brand.create!(name: 'Brand 1')
    brand2 = Brand.create!(name: 'Brand 2', sign: Brand.signs[:conglomerate], brand: brand1)
    brand3 = Brand.create(name: 'Brand 3', sign: Brand.signs[:conglomerate], brand: brand2)
    refute brand3.persisted?
    assert_equal ["У conglomerate не может быть родительский бренд, у которого так же выставлен conglomerate"], brand3.errors[:base]
  end

  test 'Дополнительная валидация на уникальность имени и родительского имени' do
    brand = Brand.new(name: 'Brand', brand: Brand.new(name: 'Brand'))
    refute brand.valid?
    assert_equal ['имя родительского бренда должно отличаться от создаваемого'], brand.errors[:brand]
  end


end
