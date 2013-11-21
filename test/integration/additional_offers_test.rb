# encoding: utf-8
#
require 'test_helper'

class AdditionalOffersTest < ActionDispatch::IntegrationTest

  test 'Дополнительные предложения не отображаются гостю, пока не нажмем соотв. кнопку' do
    visit '/user/products/new/?catalog_number=1111111111'
    assert has_selector? '.table-responsive.collapse', visible: false
  end

  test 'Дополнительные предложения отображаются пользователям' do
    auth('+7 (555) 555-55-55', '5555555555')
    visit '/user/products/new/?catalog_number=1111111111'
    assert has_selector? '.table-responsive.in'
  end

end
