# encoding: utf-8
require 'test_helper'

class EmailAddressTest < ActiveSupport::TestCase


  test 'Если сменили подтвержденный email адрес, то его статус должен стать не подтвержденный' do
    ea = FactoryGirl.create(:email_address_with_user, confirmed_by_robot: true)

    ea.email_address = 'foo@example.com'
    ea.save

    assert !ea.confirmed?
  end


  test 'Если сменился просто формат записи и email адрес подтвержден, то он не должен стать не подтвержденным' do
    ea = FactoryGirl.create(:email_address_with_user, email_address: 'foo@example.com', confirmed_by_robot: true)

    ea.email_address = 'FoO@ExAmPlE.CoM'
    ea.save

    assert ea.confirmed?
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых email адресов; email адрес считается таким без учета регистра' do
    ea1 = FactoryGirl.build(:email_address_with_user, email_address: 'ea1@example.com', confirmed_by_human: true)
    ea2 = FactoryGirl.build(:email_address_with_user, email_address: 'Ea1@ExAmPlE.cOm', confirmed_by_robot: true)

    assert ea1.valid?
    assert ea2.valid?

    ea1.save

    assert !ea2.valid?
  end

  test 'Разные пользователи могут иметь один и тот же email адрес без подтверждения' do
    ea1 = FactoryGirl.create(:email_address_with_user, email_address: 'ea1@example.com')
    ea2 = FactoryGirl.create(:email_address_with_user, email_address: 'ea1@example.com')

    assert ea1.valid?
    assert ea2.valid?
  end

  test 'Нельзя использовать email адрес, если уже существует такой же подтвержденный' do
    ea1 = FactoryGirl.create(:email_address_with_user, email_address: 'ea1@example.com', confirmed_by_human: true)
    assert ea1.valid?

    ea2 = FactoryGirl.build(:email_address_with_user, email_address: 'Ea1@ExAmPlE.com')
    assert !ea2.valid?
  end

  test 'Если имеются несколько одинаковых email адресов, то после подтверждения остальные должны быть удалены' do
    ea1 = FactoryGirl.create(:email_address_with_user, email_address: 'ea1@example.com')
    assert ea1.valid?

    ea2 = FactoryGirl.create(:email_address_with_user, email_address: 'ea1@example.com', confirmed_by_robot: true)
    assert ea2.valid?

    assert !EmailAddress.exists?(ea1)

  end

end
