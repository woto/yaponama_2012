require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  test 'После первого посещения мы должны запомниться сайтом' do
    assert_difference -> {User.count} do
      get '/'
      assert User.last.guest?
    end
    assert_equal session["guest_user_id"], User.last.id
  end

  test 'Если посетитель определяется как бот, то учетная запись не создается' do
    Bot.create(user_agent: 'i, robot')
    assert_difference -> {User.count}, 0 do
      get '/', nil, "User-Agent" => 'i, robot'
    end
    refute session["guest_user_id"]
  end

end
