# encoding: utf-8
require 'test_helper'

class EmailAddressTest < ActiveSupport::TestCase

  test 'Если сменили подтвержденный email адрес, то его статус должен стать не подтвержденный' do
    ea = email_addresses(:first_admin_email_address)
    ea.confirmed_by_user = true
    ea.save!

    ea.email_address = 'bar@example.com'
    ea.save!

    assert !ea.confirmed?
  end


  test 'Если сменился просто формат записи и email адрес подтвержден, то он не должен стать не подтвержденным' do
    ea = email_addresses(:first_admin_email_address)
    ea.confirmed_by_manager = true
    ea.save!

    ea.email_address.upcase!
    ea.save

    assert ea.confirmed?
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых email адресов; email адрес считается таким без учета регистра' do
    ea1 = email_addresses(:first_admin_email_address)
    ea1.confirmed_by_manager = true
    ea1.save!

    ea2 = ea1.dup
    assert !ea2.valid?
  end

  test 'Разные пользователи могут иметь один и тот же email адрес без подтверждения' do
    ea1 = email_addresses(:first_admin_email_address)
    assert !ea1.confirmed?

    ea2 = ea1.dup
    assert ea2.valid?
  end

  test 'Нельзя использовать email адрес, если уже существует такой же подтвержденный' do
    ea1 = email_addresses(:first_admin_email_address)
    ea1.confirmed_by_manager = true
    ea1.save!

    ea2 = ea1.dup
    ea2.confirmed_by_manager = false
    assert !ea2.valid?
  end

  test 'Если имеются несколько одинаковых email адресов, то после подтверждения остальные должны быть удалены' do
    ea1 = email_addresses(:first_admin_email_address)

    ea2 = ea1.dup
    ea2.save!
    ea2.confirmed_by_manager = true
    ea2.save!
    assert !EmailAddress.exists?(ea1)
  end

end
