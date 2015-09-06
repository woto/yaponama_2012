class UserTest < ActiveSupport::TestCase

  test 'Проверка валидаций полей пользователя с ролью guest' do
    u = User.create(role: 'guest')
    assert u.valid?
  end

  test 'Проверка валидаций полей пользователя с ролью user' do
    u = User.create(role: 'user')
    assert u.errors[:email]
    assert u.errors[:password]
    u.assign_attributes(email: 'fake@example.com', password: '12345678')
    assert u.valid?
  end

  test 'Метод to_label для гостя должен возвращать его красивый номер pretty_id' do
    travel_to Time.new(2004, 11, 24, 01, 04, 44)
    user = User.new
    user.stub(:id, 12382398) do
      assert_equal '123-823-98 2004-11-24', user.to_label
    end
  end

  test 'Проверка работы метода move_to' do
    postal_address = user_postal_addresses :sending1
    car = cars :sending1
    order = orders :sending1
    product = products :sending1

    sending1 = users :sending1
    receiving1 = users :receiving1

    sending1.move_to(receiving1)

    assert_equal receiving1, postal_address.reload.user
    assert_equal receiving1, car.reload.user
    assert_equal receiving1, order.reload.user
    assert_equal receiving1, product.reload.user
  end

end
