require 'test_helper'

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

  test 'to_label возвращает склеенные данне из контактных полей, если они заполнены для гостя' do
    user = User.create!(role: 'guest', email: 'fake@example.com', password: '12345678')
    user.stub(:id, 12382398) do
      assert_equal 'fake@example.com', user.to_label
    end
  end

  test 'to_label возвращает pretty_id, если контактные данные не заполнены' do
    travel_to Time.utc(2004, 11, 24, 01, 00, 01)
    user = User.create!(role: 'guest')
    user.stub(:id, 12382398) do
      assert_equal '123-823-98 24-11-04', user.to_label
    end
  end

  test 'Изменение часовой зоны никак не влияет на генерируемый id гостя' do
    user = User.create!(role: 'guest')
    Time.zone = Time.find_zone(-10)
    first = user.to_label
    Time.zone = Time.find_zone(10)
    last = user.to_label
    assert_equal last, first
  end

  test 'to_label возвращает склеенные данные из контактных полей для пользователя' do
    user = User.create!(role: 'user', email: 'fake@example.com', password: '12345678', name: 'user', phone: '+7 (123) 456-78-90')
    assert_equal 'user, +7 (123) 456-78-90, fake@example.com', user.to_label
  end

  test 'Обабатываем особенность отправки не заполненного поля телефон в момент, когда этот input активен' do
    user = User.new(role: 'guest', phone: '+7 (___) ___-__-__')
    user.valid?
    assert_empty user.phone
  end

end
