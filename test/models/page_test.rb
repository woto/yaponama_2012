require 'test_helper'

class PageTest < ActiveSupport::TestCase

  # Мы не отлавливаем и не проверяем изощрённые методы типа '//  // 123 //  //'

  test 'При указании path "//123" мы должны получить 123' do
    p = Page.create path: '//123'
    assert_equal '123', p.path
  end

  test 'При указании path "123/" мы должны получить 123' do
    p = Page.create path: '123/'
    assert_equal '123', p.path
  end

  test 'При указании path "123//" мы должны получить 123' do
    p = Page.create path: '123//'
    assert_equal '123', p.path
  end

  test 'При указании path "/123" мы должны получить 123' do
    p = Page.create path: '/123'
    assert_equal '123', p.path
  end

  test 'При указании path " 123 " мы должны получить 123' do
    p = Page.create path: ' 123 '
    assert_equal '123', p.path
  end

end
