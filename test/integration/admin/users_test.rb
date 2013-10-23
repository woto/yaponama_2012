# encoding: utf-8

require 'test_helper'

class Admin::UsersTest < ActionDispatch::IntegrationTest

  # TODO это может сделать только администратор

  test "Администратор может создавать новых пользователей" do
    authenticated_as('+7 (111) 111-11-11', '1111111111') do |admin|
      post_via_redirect "/admin/users", {'user' => {'id' => ''}}
      assert flash[:success] == "Пользователь был успешно создан."
    end
  end

end
