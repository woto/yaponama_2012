require 'test_helper'

class Users::SessionsTest < ActionDispatch::IntegrationTest

  test 'После входа вызывается move_to, текущий пользователь удаляется и сбрасывается guest_user_id. К сожалению замокать не удалось.' do
    brand = Brand.create!(name: 'Brand', is_brand: true)
    model = Model.create!(name: 'Model', brand: brand)
    get '/'
    old_user = User.last
    old_user.postal_addresses.create!(city: '348382834983237238949839', street: '1', house: '1', region: '1', postcode: '123456', room: '1')
    old_user.cars.create!(brand: brand, model: model, vin: '238329848923752389498273', vin_or_frame: 'vin')
    # TODO дописать проверку переноса orders и products, когда закончу с заказами

    post user_session_path, {user: {email: 'receiving1@example.com', password: '12345678'}}
    new_user = users(:receiving1)
    refute_equal new_user, old_user
    assert_raise do
      old_user.reload
    end
    assert_nil session[:guest_user_id]
    assert new_user.postal_addresses.where(city: '348382834983237238949839').exists?
    assert new_user.cars.where(vin: '238329848923752389498273').exists?
  end

end
