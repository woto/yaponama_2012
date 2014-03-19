# encoding: utf-8
#
require 'test_helper'

class PostalAddressDeliveryStepTest < ActionDispatch::IntegrationTest

  test "Мы выбираем адрес, который находится в обрабатываемой зоне" do
    skip
  end

  test 'Мы выбираем адрес, которые находится в необрабатываемой зоне' do
    skip
  end

  test 'Мы выбираем адрес, который находится в пределах автоматического расчета' do
    skip
    # В нем могут быть несколько вариантов доставки (напр. курьер и авто)
  end

  test 'Мы выбираем адрес, который находится за пределами автоматического расчета' do
    skip
  end

end
