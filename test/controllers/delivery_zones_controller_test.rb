require 'test_helper'

class DeliveryZonesControllerTest < ActionController::TestCase
  setup do
    @delivery_zone = delivery_zones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_zone" do
    assert_difference('DeliveryZone.count') do
      post :create, delivery_zone: { name: @delivery_zone.name }
    end

    assert_redirected_to delivery_zone_path(assigns(:delivery_zone))
  end

  test "should show delivery_zone" do
    get :show, id: @delivery_zone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_zone
    assert_response :success
  end

  test "should update delivery_zone" do
    patch :update, id: @delivery_zone, delivery_zone: { name: @delivery_zone.name }
    assert_redirected_to delivery_zone_path(assigns(:delivery_zone))
  end

  test "should destroy delivery_zone" do
    assert_difference('DeliveryZone.count', -1) do
      delete :destroy, id: @delivery_zone
    end

    assert_redirected_to delivery_zones_path
  end
end
