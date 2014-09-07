require 'test_helper'

class BrandTest < ActiveSupport::TestCase

  test 'Проверяем отсутсвие возможности указания в качестве родительского бренда себя' do
    brand = brands(:acura)
    brand.brand_id = brands(:acura).id
    refute brand.valid?
  end

end

