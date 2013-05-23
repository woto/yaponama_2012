# encoding: utf-8
require 'test_helper'

class PhoneTest < ActiveSupport::TestCase

  test 'Если сменили номер подтвержденного телефона, то его статус должен стать не подтвержденный' do

    p = phones(:first_admin_phone)
    assert !p.confirmed?

    p.assign_attributes(phone: '123')
    p.save!
    p.confirmed_by_user = true
    p.confirmed_by_manager = true
    assert p.confirmed?

    p.phone = '321'
    p.save!

    assert !p.confirmed?
  end

  test 'Если сменился просто формат записи и телефон подтвержден, то он должен остаться подтвержденным' do
    p = phones(:first_admin_phone)
    p.phone = '(111) 222-33-44'
    p.save!
    p.confirmed_by_manager = true
    p.confirmed_by_user = true
    p.save!
    assert p.confirmed_by_manager
    assert p.confirmed_by_user

    p.phone = '111 222 33 44'
    p.save!
    assert p.confirmed_by_manager
    assert p.confirmed_by_user
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых телефонных номеров; телефон считается таким же если совпадают только цифры номера (прочие символы откидываются)' do
    p1 = phones(:first_admin_phone)

    p1.phone = '1112223344'
    p1.save!
    p1.assign_attributes(phone_type: 'mobile_russia', confirmed_by_manager: true)
    p1.save!
    assert p1.errors[:phone].blank?

    p2 = p1.dup
    p2.assign_attributes(phone: '(111) 222-33-44', phone_type: 'unknown')
    p2.valid?
    assert p2.errors[:phone].present?
  end

  test 'Разные пользователи могут иметь один и тот же номер телефона без подтверждения' do
    p1 = Phone.new(phone: '1234567890', phone_type: 'mobile_russia')
    p2 = Phone.new(phone: '1234567890', phone_type: 'mobile_russia')

    p1.valid?
    p2.valid?

    assert p1.errors[:phone].blank?
    assert p2.errors[:phone].blank?
  end

  test 'Нельзя использовать номер телефона, если существует такой же подтвержденный' do
    p1 = phones(:first_admin_phone)
    p1.confirmed_by_manager = true
    p1.save
    assert p1.confirmed?

    p2 = p1.dup
    p2.confirmed_by_manager = false
    assert !p2.valid?
  end

  test 'Если имеются несколько одинаковых номеров телефонов, то после подтверждения остальные должны быть удалены' do
    p1 = phones(:first_admin_phone)
    assert p1.valid?

    p2 = p1.dup
    p2.save!
    p2.confirmed_by_user = true
    p2.save!

    assert !Phone.exists?(p1)
  end

  test 'При создании нового номера телефона должен генерироваться confirmation_token' do
    p = Phone.new
    p.valid?
    assert_not_nil p.confirmation_token
  end

  test 'При изменении номера телефона (реальном) происходит перегенерация confirmation_token, а при изменении формата не перегенерируется' do
    p = phones(:first_admin_phone)
    p.confirmed_by_manager = true
    p.save!

    assert p.confirmation_token.present?
    assert p.confirmed?

    p.phone = "+#{p.phone}"
    p.save!

    assert p.confirmed?

    p.phone = "2#{p.phone}"
    p.save!

    assert !p.confirmed?
  end


end
