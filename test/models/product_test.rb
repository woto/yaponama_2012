require 'test_helper'

class ProductTest < ActiveSupport::TestCase

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
