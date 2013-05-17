# encoding: utf-8

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "Пустой новый профиль должен иметь ошибки: Принадлежать пользователю, иметь имя, иметь номер телефона" do
    profile = Profile.new
    profile.valid?

    assert profile.errors[:user]    
    assert profile.errors[:names]
    assert profile.errors[:phones]
  end

  test "Профиль не может иметь более 1-ого имени или паспорта" do
    profile = Profile.new
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

end
