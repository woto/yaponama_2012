require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  test 'После посещения сайта должна создаться учетная запись с ролью guest' do
    assert_difference -> {User.count} do
      get '/'
      assert User.last.guest?
    end
  end

  test 'Если посетитель определяется как бот, то учетная запись не создается' do
    Bot.create(user_agent: 'i, robot')
    assert_difference -> {User.count}, 0 do
      get '/', nil, "User-Agent" => 'i, robot'
    end
  end

end
