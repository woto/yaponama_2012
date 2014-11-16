require 'test_helper'

class SellerNotifierMailerTest < ActionMailer::TestCase

  test 'Проверяем правильность уведомления (письма) менеджерам, о новом сообщении' do
    ActionMailer::Base.deliveries.clear
    talk = talks(:sending_to_shop)
    SellerNotifierMailer.email(talk).deliver_later
    delivery = ActionMailer::Base.deliveries.last
    assert_equal "www.test.host, новое сообщение от sending1 sending1", delivery.subject
    assert_equal ['john_doe@example.com'], delivery.to
    assert_equal ['john_doe@example.com'], delivery.from
    assert_match 'Тут сделать сначала правильное заполнение письма, а потом протестировать', delivery.body.encoded
  end

end
