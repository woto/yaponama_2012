# encoding: utf-8

require 'test_helper'

class SplitTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "Разбитие товара на партии. Проверяем количество товарных транзакций и денежных" do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    post "/admin/products/#{products(:anton_fifth).id}/split?return_path=/user", :split => {:product_id => products(:anton_fifth).id, :quantity => 1 }
    assert_equal 3, ProductTransaction.count, 'Должно было быть 3. 1 - удаление и 2 - создания'
    assert_equal 0, AccountTransaction.count, 'Деньги не изменились'
  end

end
