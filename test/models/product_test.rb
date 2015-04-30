# encoding: utf-8
#
require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'scope active для товаров это...' do
    anton = somebodies(:anton)
    active_products = anton.products.active
    assert_equal ["stock", "post_supplier", "pre_supplier", "ordered"].sort, active_products.pluck(:status).sort
  end

  test 'Товар можно перезаказать если у него статус cancel' do
    product = Product.new(:product => products(:otto13))
    product.valid?
    assert product.errors[:base].blank?
  end

  test 'Товар нельзя перезаказать если у него статус не cancel' do
    product = Product.new(:product => products(:anton_fifth))
    product.valid?
    assert_equal ["Невозможно перезаказать товар, пока по нему не выставлен отказ."], product.errors[:base]
  end

  test 'Не допустимо чтобы у объекта был бренд, с заполненным sign' do
    invalid_brand = brands(:child1_synonym)
    valid_brand = brands(:child1_child2)

    p = Product.new(catalog_number: '123', brand: invalid_brand, buy_cost: 1, sell_cost: 1, quantity_ordered: 1)
    refute p.valid?
    assert p.errors[:brand].any?

    p.brand = valid_brand
    assert p.valid?
  end

end
