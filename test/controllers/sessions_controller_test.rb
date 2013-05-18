# encoding: utf-8

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "Мы можем войти используя номер телефона и пароль" do
    post 'create', { :login => phones(:first_phone).phone, :password => '1111111111' }
    assert flash[:notice]
  end

  test "Мы можем войти используя e-mail и пароль" do
    post 'create', { :login => email_addresses(:first_email_address).email_address, :password => '1111111111' }
    assert flash[:notice]
  end

  test 'Если мы ошиблись с вводом пароля, то увидим ошибку о неправильности логина или пароля' do
    post 'create', { :login => phones(:first_phone).phone, :password => '1' }
    assert flash[:alert]
  end

end
