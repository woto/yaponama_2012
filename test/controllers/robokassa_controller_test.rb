require 'test_helper'

class RobokassaControllerTest < ActionController::TestCase

  test 'sucess успешный перевод на 11 рублей' do
   post :success, "InvId"=>"26", "OutSum"=>"11", "SignatureValue"=>"1bbac7433ca3acab128b3e31f6e762c6", "Culture"=>"ru-RU", "controller"=>"robokassa", "action"=>"success"
   assert_redirected_to user_path
   assert_equal "Успешно произведена оплата на сумму 11,00 руб.", flash[:attention]
  end

  test 'sucess не успешный перевод' do
   post :success, "InvId"=>"1", "OutSum"=>"1", "SignatureValue"=>"1", "Culture"=>"1"
   assert_template 'application/error_500'
   assert_match /Verification failed/, @response.body
  end

  test 'fail' do
    post :fail
    assert_redirected_to user_path
    assert_equal "Оплата не была произведена", flash[:attention]
  end

  test 'result успешный перевод на 111 рублей' do
    assert_equal 0, somebodies(:first_user).cached_debit
    assert_equal 0, accounts(:first_user).debit
    assert_difference ['ActionMailer::Base.deliveries.size'], +1 do
      post :result, "OutSum"=>"111", "InvId"=>"27", "SignatureValue"=>"9B7997060C320A6C6BBEF66D22460E9F"
    end
    assert_equal "OK27", @response.body
    assert_equal 111, somebodies(:first_user).reload.cached_debit.to_i
    assert_equal 111, accounts(:first_user).reload.debit.to_i
    assert assigns(:cash).valid?
    delivery = ActionMailer::Base.deliveries.last
    assert_equal "Пользователь внес оплату на сумму 111,00 руб., www.test.host", delivery.subject
    assert_equal ["john_doe@example.com"], delivery.to
    assert_equal ["john_doe@example.com"], delivery.from
  end

  test 'result не успешный перевод' do
    post :result, "OutSum"=>"1", "InvId"=>"1", "SignatureValue"=>"1"
    assert_template 'application/error_500'
    assert_match /Verification failed/, @response.body
  end

  test 'result не существующий payment' do
    post :result, "OutSum"=>"1", "InvId"=>"28", "SignatureValue"=>"7939EF17AE91CE402B37B09ADEF23ECC"
    assert_template 'application/error_500'
    assert_match /Payment didn&#39;t found/, @response.body
  end

  test 'result другая сумма payment' do
    post :result, "OutSum"=>"1", "InvId"=>"29", "SignatureValue"=>"EFF784702861A6CC6E4642EBFFFF9E54"
    assert_template 'application/error_500'
    assert_match /Cash mismatch/, @response.body
  end

  test 'routes' do
    assert_routing({ path: '/robokassa/result', method: :post }, { controller: 'robokassa', action: 'result' })
    assert_routing({ path: '/robokassa/fail', method: :post }, { controller: 'robokassa', action: 'fail' })
    assert_routing({ path: '/robokassa/success', method: :post }, { controller: 'robokassa', action: 'success' })
  end

end
