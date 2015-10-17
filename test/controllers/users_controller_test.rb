require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'Если я бот, то я не должен видеть discourse embed' do
    get :show
    assert_select 'embed', false
  end

  test 'Если я гость, то я не должен видеть discourse embed' do
    get :show
    assert_select 'embed', false
  end

  test 'Если я пользователь, то я должен видеть discourse embed' do
    sign_in users(:user)
    get :show
    assert_select 'embed'
  end
end

