# encoding: utf-8

require 'spec_helper'

describe SessionsController do
  fixtures :phones, :email_addresses, :users

  let(:with_phone) { { login: phones(:first_admin_phone).phone, password: '1111111111' } }
  let(:with_email_address) { { login: email_addresses(:first_admin_email_address).email_address, password: '1111111111' } }
  let(:with_wrong_password) { { login: phones(:first_admin_phone).phone, password: '1' } }

  describe "Мы можем войти используя" do

    it "Номер телефона и пароль" do
      post :create, with_phone
      expect(flash[:notice]).to eq "Вы успешно вошли."
    end

    it "E-mail и пароль" do
      post :create, with_email_address
      expect(flash[:notice]).to eq 'Вы успешно вошли.'
    end

  end

  it "Мы не можем войти если указан неверный пароль" do
    post :create, with_wrong_password
    expect(flash[:alert]).to eq 'Пара e-mail/телефон и пароль не найдены.'
  end

  it "Если администратор с правильно выставленным auth_token делает delete :destroy. То auth_token должен сброситься и его должно редиректнуть" do
    cookies['auth_token'] = users(:first_admin).auth_token
    delete :destroy
    expect(cookies['auth_token']).to be_nil
    expect(response.code).to eq('302')
  end

end
