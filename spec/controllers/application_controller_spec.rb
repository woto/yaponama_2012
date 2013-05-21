#encoding: utf-8

require 'spec_helper'

describe WelcomeController do
  it "Если посетитель запрашивает страницу с несуществующим auth_token'ом, то он должен быть перенаправлен на главную страницу и auth_token должен быть сброшен." do
    cookies['auth_token'] = 'auth_token_of_nonexistent_user'
    get :index
    expect(response).to redirect_to('/')
    expect(cookies['auth_token']).to be_nil
  end

  it "Если посетитель впервые посещает сайт, то в базе должен добавиться пользователь, а клиенту назначен auth_token соответствующий новой записи" do
    expect {get :index}.to change{User.count}.by(1)
    expect(response.cookies['auth_token']).not_to be_nil
    expect(User.last.auth_token).to eq(response.cookies['auth_token'])
  end
end
