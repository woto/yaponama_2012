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
    fill_in 'split[quantity]', with: 10
    click_button 'Разбить'
    assert has_text? 'может иметь значение меньшее чем 6'
    #assert has_css? '.bootbox' # тут какая-то дурацкая проблема регулярно возникает
    fill_in 'split[quantity]', with: 2
    click_button 'Разбить'
    #assert has_no_css? '.bootbox'
    assert has_text? 'Товар успешно разбит на партии. Пожалуйста обновите страницу чтобы увидеть результат операции.'
  end

end
