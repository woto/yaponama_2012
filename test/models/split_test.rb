require 'test_helper'

class SplitTest < ActiveSupport::TestCase

  test 'Если позицию разбили на две партии, то должно создастья 2 новых товара, а изначальный удалиться + работа транзакций' do
    ptc = ProductTransaction.count
    atc = AccountTransaction.count

    product = products(:ivan4)
    split = Split.new(product_id: product.id)
    split.quantity = 1
    split.save
    assert_raises ActiveRecord::RecordNotFound do
      Product.find(product.id)
    end

    first = product.products.first
    second = product.products.last

    assert_equal first.product_id, product.id
    assert_equal second.product_id, product.id

    assert_equal 1, product.product_transactions.length
    assert_equal 1, first.product_transactions.length
    assert_equal 1, second.product_transactions.length
    
    pt = product.product_transactions.first
    ft = first.product_transactions.first
    st = second.product_transactions.first

    assert_equal pt.product_id, product.id
    assert_equal ft.product_id, first.id
    assert_equal st.product_id, second.id

    assert_equal pt.operation, 'destroy'
    assert_equal ft.operation, 'create'
    assert_equal st.operation, 'create'

    assert_equal 3, ProductTransaction.count - ptc, 'Должно было быть 3 товарные транзакции.'
    assert_equal 0, AccountTransaction.count - atc, 'Не должно быть создано ни одной денежной транзакции'
  end

end
