# encoding: utf-8

require 'test_helper'

class Admin::ProfileablesControllerTest < ActionController::TestCase
  setup do
    @user = users(:first_user)
  end

  test "При добавлении администратором нового профиля nested fields names, phones, email_addresses, passports должны быть заполнены по одному" do
    @controller.class.skip_before_filter :only_authenticated
    get(:new, {'user_id' => @user.id, :resource_class => Profile}, nil, nil)
    assert true
  end

end
