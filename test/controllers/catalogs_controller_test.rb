require 'test_helper'

class CatalogsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489' do
    get :show
    assert_select '.page-header', 'Каталоги автозапчастейВыберите интересующую вас марку автомобиля'
    assert_select '.brands', /BRAND1\s+BRAND2\s+KI\s+MITSUBISHI\s+TOYOTA/m
  end

end

