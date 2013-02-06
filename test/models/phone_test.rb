# encoding: utf-8
require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  test 'Если сменили номер подтвержденного телефона, то его статус должен стать не подтвержденный' do
    p = FactoryGirl.create(:phone_with_user, :random_mobile_russia_phone, confirmed_by_robot: true)

    p.phone = '1112223344'
    p.save

    assert !p.confirmed?
  end


  test 'Если сменился просто формат записи и телефон подтвержден, то он не должен стать не подтвержденным' do
    p = FactoryGirl.create(:phone_with_user, phone: '(111) 222-33-44', phone_type: 'unknown', confirmed_by_robot: true)

    p.phone = '111 222 33 44'
    p.save

    assert p.confirmed?
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых телефонных номеров; телефон считается таким же если совпадают только цифры номера (прочие символы откидываются)' do
    p1 = FactoryGirl.build(:phone_with_user, phone: '1112223344', phone_type: 'mobile_russia', confirmed_by_robot: true)
    p2 = FactoryGirl.build(:phone_with_user, phone: '(111) 222-33-44', phone_type: 'unknown', confirmed_by_human: true)

    assert p1.valid?
    assert p2.valid?

    p1.save

    assert !p2.valid?

  end

  test 'Разные пользователи могут иметь один и тот же номер телефона без подтверждения' do
    p1 = FactoryGirl.create(:phone_with_user, phone: '1234567890', phone_type: 'mobile_russia')
    p2 = FactoryGirl.create(:phone_with_user, phone: '1234567890', phone_type: 'mobile_russia')

    assert p1.valid?
    assert p2.valid?
  end

  test 'Нельзя использовать номер телефона, если существует такой же подтвержденный' do
    p1 = FactoryGirl.create(:phone_with_user, phone: '000-00-00', phone_type: 'unknown', confirmed_by_robot: true)
    assert p1.valid?

    p2 = FactoryGirl.build(:phone_with_user, phone: '000-00-00', phone_type: 'unknown')
    assert !p2.valid?
  end

  test 'Если имеются несколько одинаковых номеров телефонов, то после подтверждения остальные должны быть удалены' do
    p1 = FactoryGirl.create(:phone_with_user, phone: '1234567890', phone_type: 'mobile_russia')
    assert p1.valid?

    p2 = FactoryGirl.create(:phone_with_user, phone: '1234567890', phone_type: 'mobile_russia', confirmed_by_human: true)
    assert p2.valid?

    assert !Phone.exists?(p1)

  end

end
