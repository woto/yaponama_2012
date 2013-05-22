# encoding: utf-8

require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  test "Администратор может создавать новых пользователей" do
    authenticated_as('1111111111', '1111111111') do |admin|
      post_via_redirect "/admin/users", {'user' => {'id' => ''}}
      assert flash[:notice] == "Пользователь был успешно создан."
    end
  end

end
