require 'test_helper'

class PostalAddressTest < ActiveSupport::TestCase

  def setup
    @pa = postal_addresses(:first_user)
  end

  test 'Не отдельно стоящее здание' do
    @pa.stand_alone_house = false
    @pa.valid?
    assert @pa.errors[:room].present?
  end

  test 'Отдельно стоящее здание' do
    @pa.stand_alone_house = true
    @pa.valid?
    assert @pa.errors[:room].blank?
  end

  test 'Индекс не может быть пустым если не Москва' do
    @pa.postcode = ''
    @pa.valid?
    assert @pa.errors[:postcode].present?
  end

  test 'Индекс может быть пустым если Москва' do
    @pa.is_moscow = true
    @pa.postcode = ''
    @pa.valid?
    assert @pa.errors[:postcode].blank?
  end

  test 'Индекс должен состоять только из цифр' do
    @pa.postcode = 'a12345'
    @pa.valid?
    assert @pa.errors[:postcode].present?
  end

  test 'Неверная длина индекса' do
    @pa.postcode = '123'
    @pa.valid?
    assert @pa.errors[:postcode].present?
  end

  test 'Правильный индекс' do
    @pa.postcode = '123456'
    @pa.valid?
    assert @pa.errors[:postcode].blank?
  end

  test 'Регион не может быть пустым, если не Москва' do
    @pa.region = ''
    @pa.valid?
    assert @pa.errors[:region].present?
  end

  test 'Регион может быть пустым, если Москва' do
    @pa.is_moscow = true
    @pa.region = ''
    @pa.valid?
    assert @pa.errors[:region].blank?
  end

  test 'Город не может быть пустым, если Москва' do
    @pa.city = ''
    @pa.valid?
    assert @pa.errors[:city].present?
  end

  test 'Город может быть пустым, если Москва' do
    @pa.is_moscow = true
    @pa.city = ''
    @pa.valid?
    assert @pa.errors[:city].blank?
  end

end
