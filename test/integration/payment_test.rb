require 'test_helper'

class PaymentTest < ActionDispatch::IntegrationTest

  test 'Проверяем первично загруженную страницу' do
    Capybara.reset!
    visit '/user/payments/new'

    # Поле для ввода суммы
    assert has_css? '#payment_amount'
    # Поля для ввода плательщика
    assert has_css? '#payment-payer', visible: false
    # Поля для ввода адреса плательщика
    assert has_css? '#payment-payer-address', visible: false
  end

  test 'После щелчка на Банковску карту, мы должны увидеть поля для ввода плательщика, но не адреса' do
    Capybara.reset!
    visit '/user/payments/new'

    find('[for=payment_payment_type_bankocean2r]').click

    # Поле для ввода суммы
    assert has_css? '#payment_amount'
    # Поля для ввода плательщика
    assert has_css? '#payment-payer'
    # Поля для ввода адреса плательщика
    assert has_css? '#payment-payer-address', visible: false
  end

  test 'После щелчка на Cбербанк, мы должны увидеть поля для ввода плательщика и адреса' do
    Capybara.reset!
    visit '/user/payments/new'

    find('[for=payment_payment_type_sberbank]').click

    # Поле для ввода суммы
    assert has_css? '#payment_amount'
    # Поля для ввода плательщика
    assert has_css? '#payment-payer'
    # Поля для ввода адреса плательщика
    assert has_css? '#payment-payer-address'
  end

end
