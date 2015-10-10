require 'test_helper'

class User::CartControllerTest < ActionController::TestCase

  test 'Когда в корзине есть товар с пустым deliveries_place_id, то должен отображаться блок Доставка' do
    sign_in(users(:user))
    get :index
    assert_select '#deliveries_place .total', text: /Итого:/
    assert_select '#deliveries_place .place', text: 'Способ получения товара: Доставка'
    assert_select '#deliveries_place  button:nth-child(2)', text: 'Оформить заказ'
  end

  test 'Когда в корзине есть товар с не пустым deliveries_place_id, то должен отображаться блок этого магазина' do
    sign_in(users(:user))
    get :index
    assert_select '#deliveries_place_309456473 .total', text: /Итого:/
    assert_select '#deliveries_place_309456473 .place', text: 'Способ получения товара: ул. Красноармейская, д.8, корп. 3, кв. 18'
    assert_select '#deliveries_place_309456473 button:nth-child(2)', text: 'Оформить заказ'
  end

  test 'Если у покупателя нет товаров в корзине, то пишем об этом' do
    get :index
    assert_select 'h4', text: 'Вы пока что не добавили ни одного товара в корзину'
  end

  test 'Строки таблицы должны помечаться id' do
    sign_in(users(:user))
    get :index
    assert_select '#deliveries_place_309456473 #row_product_536944917'
  end

  test 'Проверка удаления товара после подтверждения' do
    xhr :delete, :confirm_remove, id: products(:shop_product_incart)
    assert assigns(:resource).destroyed?
    assert assigns(:resources)
    assert_template 'update'
  end

  test 'Если я гость, то я должен видеть предложение залогиниться' do
    sign_in(users(:guest))
    get :index
    assert_select '#suggest-sign-in' do
      assert_select 'a[href="/users/sign_in"]', text: 'Войдите на сайт под своей учетной записью'
    end
  end

  test 'Если я пользователь, то я не должен видеть предложение залогиниться' do
    sign_in(users(:user))
    get :index
    assert_select '#suggest-sign-in', false
  end

  test 'Уменьшение количества штук позиции, которая в 2-х экземплярах' do
    skip
  end

  test 'Уменьшение количества штук позиции, которая в 1 экземпляре' do
    skip
  end

  test 'Увеличение количества штук позиции' do
    skip
  end

end
