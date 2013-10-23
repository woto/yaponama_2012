# encoding: utf-8

require 'test_helper'

# TODO пока это тут, до момента пока окончательно не
# разберусь с helper'ами и их тестированием

class PageTitleTest < ActionDispatch::IntegrationTest
  test 'Если заполнены @meta_title и @meta_title_small, то они должны правильно отображаться в заголовке страницы и title window' do
    Capybara.reset!
    id = phones(:otto).id
    auth('+7 (555) 555-55-55', '5555555555')
    visit "/user/phones/#{id}/confirm/view"
    h1 = find('h1')
    assert_equal 'Подтверждение +7 (111) 111-11-11', h1.text
    assert_equal '+7 (111) 111-11-11', h1.find('small').text
    assert_equal 'Подтверждение', title
  end
end
