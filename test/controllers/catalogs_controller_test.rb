require 'test_helper'

class CatalogsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489' do
    get :show
    assert_select '.page-header', 'Каталоги'
    assert_select '#catalogs-brands', /MITSUBISHI\s+TOYOTA/m
  end

end

