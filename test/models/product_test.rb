# encoding: utf-8

require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'scope active для товаров это...' do
    anton = somebodies(:anton)
    active_products = anton.products.active
    assert_equal ["stock", "post_supplier", "pre_supplier", "ordered"].sort, active_products.pluck(:status).sort
  end

end
