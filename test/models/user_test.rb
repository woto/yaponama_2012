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

  test 'Проверка работы метода move_to' do
    postal_address = postal_addresses :sending1
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

  test 'Нельзя менять роль на гостя' do
    user = User.create!(role: 'user', email: 'fake@example.com', password: '12345678')
    user.role = 'guest'
    refute user.save
  end

end
