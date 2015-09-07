require 'test_helper'

class PostalAddressTest < ActiveSupport::TestCase

  def setup
    @pa = user_postal_addresses(:first_user)
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

  test 'Индекс не может быть пустым' do
    @pa.postcode = ''
    @pa.valid?
    assert @pa.errors[:postcode].present?
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

end
