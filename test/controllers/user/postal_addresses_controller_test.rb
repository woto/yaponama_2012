require 'test_helper'

class User::PostalAddressesControllerTest < ActionController::TestCase

  test 'Проверяем набор элементов формы при создании нового адреса' do
    get :new
    assert_select "[name='postal_address[postcode]']"
    assert_select "[name='postal_address[region]']"
    assert_select "[name='postal_address[city]']"
    assert_select "[name='postal_address[street]']"
    assert_select "[name='postal_address[house]']"
    assert_select "[name='postal_address[room]']"
  end

  test 'Проверяем ошибки не заполненной формы' do
    post :create, { postal_address: { postcode: '', region: '', city: '', street: '', house: '', room: '', stand_alone_house: '0' } }
    assert_equal ["не может быть пустым", "неверной длины (может быть длиной ровно 6 символов)", "не является числом"], assigns(:resource).errors[:postcode]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:region]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:city]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:street]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:house]
    assert_equal ["не может быть пустым"], assigns(:resource).errors[:room]
  end

  test 'У созданного адреса должен быть правильно выставлен creator и user' do
    assert_difference -> {PostalAddress.count} do
      post :create, "postal_address"=>{
        postcode: '123456',
        region: '1',
        city: '1',
        street: '1',
        house: '1',
        room: '1'
      }
    end
    assert_equal User.last, assigns(:resource).user
    assert_equal User.last, assigns(:resource).creator
  end

  test 'Если ipgeobase_name Москва, то is_moscow по-умолчанию true' do
    sign_in(users(:user))
    @request.remote_addr = '176.195.87.131'
    get :new
    assert_equal true, assigns(:resource).is_moscow
  end

  test 'Если ipgeobase_name не Москва, то is_moscow по-умолчанию не true' do
    sign_in(users(:user))
    get :new
    assert_not_equal true, assigns(:resource).is_moscow
  end
end
