# encoding: utf-8

class UserTest < ActiveSupport::TestCase

  test 'Если у нового созданного в памяти пользователя есть один профиль, то он автоматически должен стать главным' do
    u = User.new
    p = u.profiles.new
    u.valid?
    assert_equal p, u.main_profile
    assert u.errors["main_profile"].blank?
  end

  test 'Если у уже сохраненного пользователя заполняется первый профиль, то он должен стать главным' do
    u = users(:stan)
    assert u.valid?
    profile = u.profiles.new
    name = profile.names.new
    name.creation_reason = 'fixtures'
    name.name = 'Стэн'
    assert u.valid?
  end

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
