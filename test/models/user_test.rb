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

  test 'При изменении профиля, который выставлен в качестве основного должны измениться закешированные поля профиля cached_names, cached_phones и т.д. и закешированное значение главного профиля пользователя cached_main_profile' do
    u = users(:stan)
    assert u.profiles.blank?
    profile = u.profiles.new
    name = profile.names.new
    name.creation_reason = 'fixtures'
    name.name = 'Стэн'
    phone = profile.phones.new
    phone.phone = '123'
    phone.phone_type = 'unknown'
    phone.creation_reason = 'fixtures'
    email_address = profile.email_addresses.new
    email_address.email_address = 'fake@example.com'
    passport = profile.passports.new(:gender => 'male', :seriya => '1', :nomer => '1', :passport_vidan => '1', :data_vidachi => DateTime.now, :kod_podrazdeleniya => '1', :data_rozhdeniya => DateTime.now, :mesto_rozhdeniya => 'Новый Дурулгуй')
    u.save!
    assert_equal 'Стэн', u.cached_main_profile['names'].first['name']
    assert_equal 'fake@example.com', u.cached_main_profile['email_addresses'].first['email_address']
    assert_equal '123', u.cached_main_profile['phones'].first['phone']
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


  # TODO Это необходимо вынести в контроллер
  #test 'В случае невозможности выставления TimeОшибка в ассоциации time_zone должна вызвать ошибку в модели пользователя' do
  #  u = User.new
  #  tz = TimeZone.new
  #  u.time_zone = tz
  #  assert !u.valid?
  #end

end
