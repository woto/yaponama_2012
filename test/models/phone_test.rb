# encoding: utf-8
#
require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  test 'Если сменили номер подтвержденного телефона (мобильного) без флага confirm_required, то его статус должен остаться прежним, а смс не должна быть отправлена' do
    # TODO Этот тест удалится, т.к. есть более правильный на уровне контроллера
    ActionMailer::Base.deliveries.clear

    p = phones(:mark)
    p.value = '+7 (321) 321-32-11'
    p.save!

    assert p.confirmed?
    assert_equal 0, ActionMailer::Base.deliveries.size
  end


  test 'Если сменился просто формат записи и телефон подтвержден, то он должен остаться подтвержденным даже с выставленным флагом confirm_required' do
    # TODO Этот тест удалится, т.к. есть более правильный на уровне контроллера
    p = phones(:otto3)
    p.value = '8 888 888 88 88'
    p.save!
    assert p.confirmed?
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых телефонных номеров; телефон считается таким же если совпадают только цифры номера (прочие символы откидываются)' do
    p1 = phones(:first_admin)

    p1.value = '+7 (111) 222-33-44'
    p1.save!
    p1.assign_attributes(mobile: true, confirmed: true)
    p1.save!
    assert p1.errors[:value].blank?

    p2 = p1.dup
    p2.assign_attributes(value: '71112223344', mobile: '0')
    p2.valid?
    assert p2.errors[:value].present?
  end

  test 'Разные пользователи могут иметь один и тот же номер телефона без подтверждения' do
    pr1 = profiles(:otto)
    ph1 = pr1.phones.new(value: '1234567890', mobile: '0', creation_reason: 'fixtures')
    pr1_count = pr1.phones.count

    pr2 = profiles(:mark)
    ph2 = pr2.phones.new(value: '1234567890', mobile: '0', creation_reason: 'fixtures')
    pr2_count = pr2.phones.count

    pr1.save!
    pr2.save!

    assert_equal pr1.phones(true).count, pr1_count+1
    assert_equal pr2.phones(true).count, pr2_count+1
  end

  test 'Нельзя использовать номер телефона, если существует такой же подтвержденный' do
    p1 = phones(:first_admin)
    p1.confirmed = true
    p1.save
    assert p1.confirmed?

    p2 = p1.dup
    p2.confirmed = false
    assert !p2.valid?
  end

  test 'Если имеются несколько одинаковых номеров телефонов, то после подтверждения остальные должны быть удалены' do
    p1 = phones(:first_admin)
    p2 = phones(:otto)
    p2.confirmed = true
    p2.save!
    assert !Phone.exists?(p1.id)
  end

  test 'При создании нового номера телефона должен генерироваться confirmation_token (Если не confirmed)' do
    u = somebodies(:first_admin)
    p = u.profiles.first.phones.new(value: '+7 (123) 456-78-90', mobile: true, creation_reason: 'fixtures', confirmed: false)
    p.save!
    assert_not_nil p.confirmation_token
  end

  test 'При создании нового номера телефона не должен генерироваться confirmation_token (Если confirmed)' do
    u = somebodies(:first_admin)
    p = u.profiles.first.phones.new(value: '123', mobile: false, creation_reason: 'fixtures', confirmed: true)
    p.save!
    assert_nil p.confirmation_token
  end

  test 'При изменении номера телефона (формата записи) перегенерации confirmation_token не происходит даже при выставленном флаге confirm_required' do
    p = phones(:otto3)
    old_confirmation_token = p.confirmation_token
    p.value = '8 8888888888'
    p.save!
    new_confirmation_token = p.confirmation_token
    assert_equal new_confirmation_token, old_confirmation_token
  end

  test 'Проверка validators/phone_validator' do
    phone = Phone.new(value: '123', mobile: false)
    phone.valid?
    assert_empty phone.errors[:value]

    phone.mobile = true
    phone.valid?
    assert_equal ['имеет неверное значение'], phone.errors[:value]

    phone.value = '+7 (948) 392-72-30'
    phone.valid?
    assert_empty phone.errors[:value]

  end

end
