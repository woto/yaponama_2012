# encoding: utf-8
#
require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "Пустой новый профиль должен иметь ошибки: Принадлежать пользователю, иметь имя, иметь номер телефона" do
    u = somebodies(:stan)
    profile = u.profiles.new
    profile.valid?

    assert profile.errors[:user]    
    assert profile.errors[:names]
    assert profile.errors[:phones]
  end

  test "Профиль не может иметь более 1-ого имени или паспорта" do
    u = somebodies(:stan)
    profile = u.profiles.new
    1.times do
      profile.passports.new
      profile.names.new
    end
    profile.valid?

    assert profile.errors[:names].blank?
    assert profile.errors[:passports].blank?

    1.times do
      profile.passports.new
      profile.names.new
    end
    profile.valid?

    assert profile.errors[:names]
    assert profile.errors[:passports]
  end

  test 'Если у пользователя заполнен хотя бы один профиль, то его удалить уже нельзя. (Если регистрация происходит через email или телефон. То можно удалить контакт и не иметь возможности зайти на сайт с контактом - паролем)' do
    u = somebodies(:stan)
    p = u.profiles.first
    refute p.destroy
  end

end
