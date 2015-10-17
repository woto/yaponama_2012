require 'test_helper'

class Admin::BrandsControllerTest < ActionController::TestCase

  def setup
    sign_in users(:admin)
  end

  test 'Проверяем сохранение родительско бренда' do
    kia = brands(:kia)
    ki = brands(:ki)

    assert_equal nil, ki.brand

    patch :update,
      "brand" => {
        "sign"=> "synonym",
        "name"=>"KI",
        "brand_attributes" => {
          "name"=>"KIA"
        }
      }, "id" => ki

    # Проверяем присвоение родителя
    assert_equal kia, ki.reload.brand
  end

end
