# encoding: utf-8
#
class UserTest < ActiveSupport::TestCase

  test 'Если у пользователя заполняется первый профиль, то он должен стать главным' do
    u = somebodies(:stan)
    assert u.valid?
    profile = u.profiles.new(creation_reason: 'fixtures')
    name = profile.names.new
    name.creation_reason = 'frontend'
    name.name = 'Стэн'
    assert u.valid?
  end

  test 'При изменении профиля, который выставлен в качестве основного должны измениться закешированные поля профиля cached_names, cached_phones и т.д. и закешированное значение главного профиля пользователя cached_profile' do
    u = somebodies(:stan)
    profile = u.profiles.new(code_1: 'frontend')
    name = profile.names.new
    name.name = 'Стэн'
    ph = profile.phones.new
    ph.value = '123'
    ph.mobile = false
    email = profile.emails.new
    email.value = 'test@example.com'
    passport = profile.passports.new(:gender => 'male', :seriya => '1', :nomer => '1', :passport_vidan => '1', :data_vidachi => DateTime.now, :kod_podrazdeleniya => '1', :data_rozhdeniya => DateTime.now, :mesto_rozhdeniya => 'Новый Дурулгуй')
    u.profile = profile
    u.save!
    assert_equal 'Стэн', JSON.parse(u.cached_profile)['names'].first['name']
    assert_equal 'test@example.com', JSON.parse(u.cached_profile)['emails'].first['value']
    assert_equal '123', JSON.parse(u.cached_profile)['phones'].first['value']
    assert_equal 'Новый Дурулгуй', JSON.parse(u.cached_profile)['passports'].first['mesto_rozhdeniya']
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

    assert_equal ["недостаточной длины (не может быть меньше 6 символа)"], u.errors[:password]
    assert u.errors[:password_confirmation].blank?
  end

  test 'Пароль не совпадает с подтверждением' do
    u = User.new
    u.password_required = true

    u.password = '123456'
    u.password_confirmation = '654321'

    u.valid?

    assert u.errors[:password].blank?
    assert_equal ["не совпадает со значением поля Пароль"], u.errors[:password_confirmation]
  end


  test 'Если менется profile_id' do
    p1 = profiles(:mile_main)
    p2 = profiles(:mile_not_main)

    mile = somebodies(:mile)

    # Это приходит в контроллере, поэтому сохраняю условия изменения (id приходит из селекта)
    mile.profile_id = p2.id
    old = mile.cached_profile

    mile.save
    new = mile.reload.cached_profile
    refute_equal new, old
  end


  test 'Если менется profile (Ради эксперимента сравниваю вмест _id сам объект)' do
    p1 = profiles(:mile_main)
    p2 = profiles(:mile_not_main)

    mile = somebodies(:mile)

    mile.profile = p2
    old = mile.cached_profile

    mile.save
    new = mile.reload.cached_profile
    refute_equal new, old
  end

  test 'Если удаляем основной профиль, то другой должен стать основным' do
    p1 = profiles(:mile_main)
    p2 = profiles(:mile_not_main)

    mile = somebodies(:mile)

    p1.destroy 

    assert_equal p2, mile.reload.profile
  end



  # TODO Это необходимо вынести в контроллер
  #test 'В случае невозможности выставления TimeОшибка в ассоциации time_zone должна вызвать ошибку в модели пользователя' do
  #  u = User.new
  #  tz = TimeZone.new
  #  u.time_zone = tz
  #  assert !u.valid?
  #end

end
