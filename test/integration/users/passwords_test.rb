require 'test_helper'

class Users::SessionsTest < ActionDispatch::IntegrationTest

  test 'После восстановления пароля вызывается move_to, текущий пользователь удаляется и сбрасывается guest_user_id. К сожалению замокать не удалось.' do
    brand = Brand.create!(name: 'Brand', is_brand: true)
    model = Model.create!(name: 'Model', brand: brand)
    get '/'
    old_user = User.last
    old_user.postal_addresses.create!(city: '0938573905473895729484372849', street: '1', house: '1', region: '1', postcode: '123456', room: '1')
    old_user.cars.create!(brand: brand, model: model, vin: '48503828405843872749583782', vin_or_frame: 'vin')
    # TODO дописать проверку переноса orders и products, когда закончу с заказами

    new_user = users(:receiving1)
    token = new_user.send(:set_reset_password_token)

    patch user_password_path, {user: {reset_password_token: token, email: 'receiving1@example.com', password: '12345678', password_confirmation: '12345678'}}

    refute_equal new_user, old_user
    assert_raise do
      old_user.reload
    end
    assert_nil session[:guest_user_id]
    assert new_user.postal_addresses.where(city: '0938573905473895729484372849').exists?
    assert new_user.cars.where(vin: '48503828405843872749583782').exists?
  end
end

