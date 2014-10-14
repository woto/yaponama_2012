# encoding: utf-8
#
require 'test_helper'

class SplitsTest < ActionDispatch::IntegrationTest

  test 'У позиции в info должна быть ссылка если больше 1' do
    ivan = somebodies(:ivan)
    visit '/'
    create_cookie 'auth_token', ivan.auth_token
    visit "/admin/users/#{ivan.id}/products"
    find("#id_product_#{products(:ivan1).id} > a").click
    assert has_text? 'Разбить на партии'
  end

  test 'У позиции в info не должно быть ссылки если кол-во 1' do
    ivan = somebodies(:ivan)
    visit '/'
    create_cookie 'auth_token', ivan.auth_token
    visit "/admin/users/#{ivan.id}/products"
    find("#id_product_#{products(:ivan2).id} > a").click
    assert has_text? 'Информация об элементе'
    assert has_no_text? 'Разбить на партии'
  end

  test 'Если мы ввели неправильное число, то мы должны увидеть окно с предложением повтороного ввода' do
    ivan = somebodies(:ivan)
    visit '/'
    create_cookie 'auth_token', ivan.auth_token
    visit "/admin/users/#{ivan.id}/products"
    find("#id_product_#{products(:ivan3).id} > a").click
    click_link 'Разбить на партии'
    page.document.synchronize do
      fill_in 'split_quantity', with: '10'
      if has_field?('split_quantity', :with => '10', visible: false)
      else
        nil
      end
    end
    click_button 'Разбить'
    has_text? 'может иметь значение меньшее чем 6'
    page.document.synchronize do
      fill_in 'split_quantity', with: '2'
      if has_field?('split_quantity', :with => '2', visible: false)
      else
        nil
      end
    end
    click_button 'Разбить'
    has_text? 'Товар успешно разбит на партии. Пожалуйста обновите страницу чтобы увидеть результат операции.'
  end

end
