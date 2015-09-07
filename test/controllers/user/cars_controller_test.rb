require 'test_helper'

class User::CarsControllerTest < ActionController::TestCase
  test 'У созданного автомобиля должен быть правильно выставлен creator и user' do
    assert_difference -> {User::Car.count} do
      post :create, "user_car"=>{
        "vin_or_frame"=>"vin",
        "vin"=>"12345678901234567",
        "brand_attributes"=>{"name"=>"Brand"},
        "model_attributes"=>{"name"=>"Model"}}
    end
    assert_equal User.last, User::Car.last.creator
    assert_equal User.last, User::Car.last.user
  end
end
