# encoding: utf-8

require 'test_helper'

class PostalAddressTest < ActiveSupport::TestCase

  test 'Проверяем взаимодействие флага на требование к заполнению номера дома' do
    pa = PostalAddress.new(code_1: 'frontend profile')

    # Не отдельно стоящее
    pa.stand_alone_house = false
    pa.valid?
    assert pa.errors[:room].present?

    # Отдельно стоящее
    pa.stand_alone_house = true
    pa.valid?
    assert pa.errors[:room].blank?
  end

  test 'Проверяем валидацию почтового индекса' do
    pa = PostalAddress.new(code_1: 'frontend profile')

    # Пустое значение
    pa.postcode = ''
    pa.valid?
    assert pa.errors[:postcode].present?

    # Состоит не из цифр
    pa.postcode = 'a12345'
    pa.valid?
    assert pa.errors[:postcode].present?

    # Цифр не шесть
    pa.postcode = '123'
    pa.valid?
    assert pa.errors[:postcode].present?

    # Правильное значение
    pa.postcode = '123456'
    pa.valid?
    assert pa.errors[:postcode].blank?
  end

  test 'Почтовый адрес нельзя удалить, если он используется в ### (Указан как адрес у компании {возможно еще где-то заказы и т.д.})' do
    skip
  end

end
