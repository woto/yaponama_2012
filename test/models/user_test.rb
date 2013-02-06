# encoding: utf-8

class UserTest < ActiveSupport::TestCase
  
  test 'Только что инициализированный пользователь должен содержать предопределенный набор ошибок' do
    u = FactoryGirl.build(:user)
    u.valid?

    assert u.errors.include?(:discount)
    assert u.errors.include?(:prepayment_percent)
    assert u.errors.include?(:order_rule)
    assert u.errors.include?(:role)
    assert u.errors.include?(:account)
  end


  test 'Минимально заполненный пользователь должен быть валиден' do
    u = FactoryGirl.build(:minimal_valid_user)
    assert u.valid?
  end

  test 'Если выставлен флаг password_required, то наличие пароля обязательно' do
    u = FactoryGirl.build(:user)
    u.password_required = true
    u.valid?
    assert u.errors.include?(:password)
  end


  test 'Ошибка в ассоциации time_zone должна вызвать ошибку в модели пользователя' do
    u = FactoryGirl.build(:minimal_valid_user) 
    u.time_zone = FactoryGirl.build(:minimal_valid_time_zone, time_zone: '')
    assert !u.valid?
  end

end
