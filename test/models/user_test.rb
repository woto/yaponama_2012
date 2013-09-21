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
    profile = u.profiles.new(creation_reason: 'fixtures')
    name = profile.names.new
    name.creation_reason = 'frontend'
    name.name = 'Стэн'
    assert u.valid?
  end

  test 'При изменении профиля, который выставлен в качестве основного должны измениться закешированные поля профиля cached_names, cached_phones и т.д. и закешированное значение главного профиля пользователя cached_main_profile' do
    u = users(:stan)
    profile = u.profiles.new(code_1: 'frontend')
    name = profile.names.new
    name.name = 'Стэн'
    ph = profile.phones.new
    ph.value = '123'
    ph.mobile = false
    email = profile.emails.new
    email.value = 'test@example.com'
    passport = profile.passports.new(:gender => 'male', :seriya => '1', :nomer => '1', :passport_vidan => '1', :data_vidachi => DateTime.now, :kod_podrazdeleniya => '1', :data_rozhdeniya => DateTime.now, :mesto_rozhdeniya => 'Новый Дурулгуй')
    u.main_profile = profile
    u.save!
    assert_equal 'Стэн', u.cached_main_profile['names'].first['name']
    assert_equal 'test@example.com', u.cached_main_profile['emails'].first['value']
    assert_equal '123', u.cached_main_profile['phones'].first['value']
    assert_equal 'Новый Дурулгуй', u.cached_main_profile['passports'].first['mesto_rozhdeniya']
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

  test 'Пароль короче 6-и символов' do
    u = User.new
    u.password_required = true

    u.password = '123'
    u.password_confirmation = '123'

    u.valid?

    assert_equal ["недостаточной длины (не может быть меньше 6 символов)"], u.errors[:password]
    assert u.errors[:password_confirmation].blank?
  end

  test 'Пароль не совпадает с подтверждением' do
    u = User.new
    u.password_required = true

    u.password = '123456'
    u.password_confirmation = '654321'

    u.valid?

    assert u.errors[:password].blank?
    assert_equal ["не совпадает с подтверждением"], u.errors[:password_confirmation]
  end


  # TODO Это необходимо вынести в контроллер
  #test 'В случае невозможности выставления TimeОшибка в ассоциации time_zone должна вызвать ошибку в модели пользователя' do
  #  u = User.new
  #  tz = TimeZone.new
  #  u.time_zone = tz
  #  assert !u.valid?
  #end

end
