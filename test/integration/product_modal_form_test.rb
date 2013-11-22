# encoding: utf-8
#
require 'test_helper'

class ProductModalFormTest < ActionDispatch::IntegrationTest
  test 'Если в адресной строке имеется ключ modal=... при создании товара, то должно показаться модальное окно' do
    Capybara.reset!
    visit '/user/products/new/?modal=true'
    assert has_css? '#modal_form', 'Модальное окно с редактирование товара не отобразилось'
  end

  test 'И наоборот если в адресной строке нет ключа modal=..., то модальное окно не показывается' do
    Capybara.reset!
    visit '/user/products/new/'
    assert has_no_css? '#modal_form', 'Модальное окно с редактирование товара отобразилось'
  end
end
