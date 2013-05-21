#encoding: utf-8

require 'spec_helper'

describe WelcomeController do
  it "Если пользователь запрашивает страницу с несуществующим в базе пользователей auth_token'ом, то он должен быть перенаправлен на главную страницу. и auth_token должен быть сброшен." do
    request.cookies['auth_token'] = 'auth_token_of_nonexistent_user'
    get :index
    response.should redirect_to('/')
    expect(response.cookies['auth_token']).to eq(nil)
  end

  it "Если сайт посещает новый пользователь, то должна создаться новая запись в базе пользователей" do
    expect { get :index }.to change{ User.count }.by(1)
  end

end
