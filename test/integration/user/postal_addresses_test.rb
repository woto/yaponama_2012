require 'test_helper'

class PostalAddressesTest < ActionDispatch::IntegrationTest

  test 'После щелчка на stand_alone_house room должен спрятаться' do
    visit '/user/postal_addresses/new'
    assert has_css?('.postal_address_room')
    check 'Отдельно стоящее здание'
    assert has_css?('.postal_address_room', visible: :hidden)
  end

  test 'С выставленной галочкой stand_alone_house room должен быть спрятанным' do
    login_as(users(:user_from_moscow_in_stand_alone_house))
    visit edit_user_postal_address_path(postal_addresses(:user_from_moscow_in_stand_alone_house))
    assert has_css?('.postal_address_room', visible: :hidden)
  end

  test 'После щелчка на is_moscow должны спрятаться лишние поля' do
    visit '/user/postal_addresses/new'
    assert has_css?('.postal_address_postcode')
    assert has_css?('.postal_address_region')
    assert has_css?('.postal_address_city')
    check 'г. Москва'
    assert has_css?('.postal_address_postcode', visible: :hidden)
    assert has_css?('.postal_address_region', visible: :hidden)
    assert has_css?('.postal_address_city', visible: :hidden)
  end

  test 'С выставленной галочкой is_moscow лишние поля должен быть спрятанными' do
    login_as(users(:user_from_moscow_in_stand_alone_house))
    visit edit_user_postal_address_path(postal_addresses(:user_from_moscow_in_stand_alone_house))
    assert has_css?('.postal_address_postcode', visible: :hidden)
    assert has_css?('.postal_address_region', visible: :hidden)
    assert has_css?('.postal_address_city', visible: :hidden)
  end

end
