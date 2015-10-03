require 'test_helper'

class Admin::Deliveries::PlacesControllerTest < ActionController::TestCase
  test 'Минимальный тест на создание зоны доставки' do
    assert_difference -> {Deliveries::Place.count} do
      post :create, deliveries_place: {
        "partner"=>"0",
        "active"=>"1",
        "z_index"=>"100",
        "realize"=>"1",
        "name"=>"Название",
        "metro"=>"",
        "variants_attributes"=>
         {"0"=>{"_destroy"=>"false", "name"=>"Курьер", "active"=>"1", "sequence"=>"10", "delivery_cost"=>"100", "option_id"=>"", "content"=>""}},
        "display_marker"=>"0",
        "price_url"=>"",
        "vertices"=>"ijksIqlodFpvDxtA?ybH{iE?"}
    end
  end
end
