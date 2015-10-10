require 'test_helper'

class PostalAddressesTest < ActionDispatch::IntegrationTest

  test 'После щелчка на stand_alone_house room должен спрятаться' do
    visit '/user/postal_addresses/new'
    assert has_css?('[room]')
    find('[stand_alone_house]').click
    assert has_css?('[room]', visible: false)
  end

  test 'С выставленной галочкой stand_alone_house room должен быть спрятанным' do
    login_as(users(:lee))
    visit edit_user_postal_address_path(postal_addresses(:lee))
    assert has_css?('[room]', visible: false)
  end
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
    login_as(users(:lee))
    visit edit_user_postal_address_path(postal_addresses(:lee))
    assert has_css?('.postal_address_postcode', visible: :hidden)
    assert has_css?('.postal_address_region', visible: :hidden)
    assert has_css?('.postal_address_city', visible: :hidden)
  end

end
