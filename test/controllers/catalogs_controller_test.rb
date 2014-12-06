require 'test_helper'

class CatalogsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489' do
    get :show
    assert_select '.page-header', 'Каталоги'
    assert_select '#catalogs-brands', /ЗАПЧАСТИ НА MITSUBISHI\s+ЗАПЧАСТИ НА TOYOTA/m
  end

end

