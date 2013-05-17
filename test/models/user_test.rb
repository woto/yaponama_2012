# encoding: utf-8

class UserTest < ActiveSupport::TestCase
  
  test 'Только что инициализированный пользователь должен содержать предопределенный набор ошибок' do
    u = User.new
    u.valid?

    assert u.errors[:discount]
    assert u.errors[:prepayment]
    assert u.errors[:order_rule]
    assert u.errors[:role]
    assert u.errors[:account]
  end


  test 'Если выставлен флаг password_required, то наличие пароля обязательно' do
    u = User.new

    u.password_required = true
    u.valid?
    assert u.errors[:password]

    u.password_required = false
    u.valid?
    assert u.errors[:password].blank?

  end


  # TODO Это необходимо вынести в контроллер
  #test 'В случае невозможности выставления TimeОшибка в ассоциации time_zone должна вызвать ошибку в модели пользователя' do
  #  u = User.new
  #  tz = TimeZone.new
  #  u.time_zone = tz
  #  assert !u.valid?
  #end

end
