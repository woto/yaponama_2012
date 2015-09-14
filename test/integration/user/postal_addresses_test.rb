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

