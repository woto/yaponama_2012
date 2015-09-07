require 'test_helper'

class UserHelperTest < ActionView::TestCase
  test 'Метод guest_or_user_to_label для гостя должен возвращать его красивый номер pretty_id' do
    travel_to Time.new(2004, 11, 24, 01, 04, 44)
    user = User.create!(role: 'guest', email: 'fake@example.com', password: '12345678')
    user.stub(:id, 12382398) do
      assert_equal '123-823-98 2004-11-24', guest_or_user_to_label(user)
    end
  end

  test 'Метод guest_or_user_to_label для не гостя возвращяет сначала name, потом ...' do
    user = User.create!(role: 'user', email: 'fake@example.com', password: '12345678', name: 'user')
    assert_equal 'user', guest_or_user_to_label(user)

  end
end
