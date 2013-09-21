# encoding: utf-8

require 'test_helper'

class PostalAddressesControllerTest < ActionController::TestCase

  test 'Проверяем набор элементов формы при создании нового адреса' do
    get :new, :resource_class => 'PostalAddress'
    assert_select "[name='postal_address[postcode]']"
    assert_select "[name='postal_address[region]']"
    assert_select "[name='postal_address[city]']"
    assert_select "[name='postal_address[street]']"
    assert_select "[name='postal_address[house]']"
    assert_select "[name='postal_address[room]']"
  end

  test 'Проверяем ошибки не заполненной формы' do

    post :create, { resource_class: 'PostalAddress', postal_address: { postcode: '', region: '', city: '', street: '', house: '', room: '' } }

    assert_equal ["не может быть пустым", "неверной длины (может быть длиной ровно 6 символов)", "не является числом"], assigns(:resource).errors[:postcode]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:region]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:city]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:street]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:house]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:room]

  end

end
