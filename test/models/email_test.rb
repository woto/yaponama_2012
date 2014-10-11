# encoding: utf-8
#
require 'test_helper'

class EmailTest < ActiveSupport::TestCase

  test 'Если сменили подтвержденный email адрес без флага confirm_required, то его статус должен сохранить прежнее состояние и письмо не должно быть отправлено с запросом на подтверждение (т.е. адрес изменил менеджер)' do
    ActionMailer::Base.deliveries.clear
    ea = emails(:mark)
    ea.value = 'bar@example.com'
    ea.save
    assert ea.confirmed?
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test 'Если сменился просто формат записи и email адрес подтвержден, то он не должен стать не подтвержденным и письмо не должно быть отправлено с ссылкой для подтверждения' do
    ActionMailer::Base.deliveries.clear
    ea = emails(:first_admin)
    ea.confirmed = true
    ea.save!
    ea.value.upcase!
    ea.save
    assert ea.confirmed?
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test 'При проверке на возможность существования нескольких подтвержденных одинаковых email адресов; email адрес считается таким без учета регистра' do
    ea1 = emails(:first_admin)
    ea1.confirmed = true
    ea1.save!

    ea2 = ea1.dup
    assert !ea2.valid?
  end

  test 'Разные пользователи могут иметь один и тот же email адрес без подтверждения' do
    ea1 = emails(:first_admin)
    ea2 = emails(:otto)
    assert ea1.valid?
    assert ea2.valid?
  end

  test 'Нельзя использовать email адрес, если уже существует такой же подтвержденный' do
    ea1 = emails(:first_admin)
    ea1.confirmed = true
    ea1.save!

    ea2 = ea1.dup
    ea2.confirmed = false
    assert !ea2.valid?
  end

  test 'Если имеются несколько одинаковых email адресов, то после подтверждения остальные должны быть удалены' do
    ea1 = emails(:first_admin)
    ea2 = emails(:otto)
    ea2.confirmed = true
    ea2.save!
    assert !Email.exists?(ea1.id)
  end

  test 'Проверка validators/email_validator' do
    e = Email.new(value: 'fake@mail.ru')
    e.valid?
    assert_empty e.errors[:value]

    e.value = 'test'
    e.valid?
    assert_equal ['имеет неверное значение'], e.errors[:value]
  end
end
