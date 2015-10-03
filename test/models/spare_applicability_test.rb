require 'test_helper'

class SpareApplicabilityTest < ActiveSupport::TestCase

  test "Нельзя создать применимость для бренда, который не выпускает автомобили" do
    spare_info = spare_infos(:infiniti_3310)
    brand = Brand.create!(name: 'Brand')
    spare_applicability = SpareApplicability.new(brand: brand, spare_info: spare_info)
    refute spare_applicability.valid?
    assert_equal ["Нельзя указать производителя, который не отмечен как выпускающий автомобили."], spare_applicability.errors[:brand]
  end

  test 'Можно создать применимость для бренда, который выпускает автомобили' do
    spare_info = spare_infos(:infiniti_3310)
    brand = Brand.create!(name: 'Brand', is_brand: true)
    model = Model.create!(name: 'Model', brand: brand)
    spare_applicability = SpareApplicability.new(brand: brand, model: model, spare_info: spare_info)
    assert spare_applicability.valid?
  end

end

