require 'test_helper'

class User::CarsControllerTest < ActionController::TestCase

  setup do
    @brands_count = Brand.count
    @models_count = Model.count
    @generations_count = Generation.count
    @modifications_count = Modification.count
  end

  test 'У созданного автомобиля должен быть правильно выставлен creator и user' do
    assert_difference -> {Car.count} do
      post :create, car: {
        "vin_or_frame"=>"vin",
        "vin"=>"12345678901234567",
        "brand_attributes"=>{"name"=>"Brand"},
        "model_attributes"=>{"name"=>"Model"}}
    end
    assert_equal User.last, assigns(:resource).creator
    assert_equal User.last, assigns(:resource).user
  end

  test 'Бренд созданного автомобиля должен быть отмечен как is_brand' do
    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"Brand"},
      "model_attributes"=>{"name"=>"Model"}}

    assert assigns(:resource).brand.is_brand
  end

  test 'Проверка созданных бренда, модели, поколения, модификации' do
    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"New brand"},
      "model_attributes"=>{"name"=>"New model"},
      "generation_attributes"=>{"name"=>"New generation"},
      "modification_attributes"=>{"name"=>"New modification"}}

    assert_equal 'New brand', Brand.last.name
    assert_equal 'New model', Model.last.name
    assert_equal 'New generation', Generation.last.name
    assert_equal 'New modification', Modification.last.name
  end

  test 'Проверка новой модификации' do
    brands_count = Brand.count
    models_count = Model.count
    generations_count = Generation.count
    modifications_count = Modification.count

    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"TOYOTA"},
      "model_attributes"=>{"name"=>"Camry"},
      "generation_attributes"=>{"name"=>"Camry (XV50) (2011)"},
      "modification_attributes"=>{"name"=>"New modification"}}

    assert_equal Brand.count, @brands_count
    assert_equal Model.count, @models_count
    assert_equal Generation.count, @generations_count
    assert_equal Modification.count, @modifications_count + 1
  end

  test 'Проверка нового поколения' do
    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"TOYOTA"},
      "model_attributes"=>{"name"=>"Camry"},
      "generation_attributes"=>{"name"=>"New generation"},
      "modification_attributes"=>{"name"=>"New modification"}}

    assert_equal Brand.count, @brands_count
    assert_equal Model.count, @models_count
    assert_equal Generation.count, @generations_count + 1
    assert_equal Modification.count, @modifications_count + 1
  end

  test 'Проверка новой модели' do
    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"TOYOTA"},
      "model_attributes"=>{"name"=>"New model"},
      "generation_attributes"=>{"name"=>"New generation"},
      "modification_attributes"=>{"name"=>"New modification"}}

    assert_equal Brand.count, @brands_count
    assert_equal Model.count, @models_count + 1
    assert_equal Generation.count, @generations_count + 1
    assert_equal Modification.count, @modifications_count + 1
  end

  test 'Проверка нового бренда' do
    post :create, car: {
      "vin_or_frame"=>"vin",
      "vin"=>"12345678901234567",
      "brand_attributes"=>{"name"=>"New brand"},
      "model_attributes"=>{"name"=>"New model"},
      "generation_attributes"=>{"name"=>"New generation"},
      "modification_attributes"=>{"name"=>"New modification"}}

    assert_equal Brand.count, @brands_count + 1
    assert_equal Model.count, @models_count + 1
    assert_equal Generation.count, @generations_count + 1
    assert_equal Modification.count, @modifications_count + 1
  end

end
