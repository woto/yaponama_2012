require 'test_helper'

class SellerNotifierMailerTest < ActionMailer::TestCase

  test 'Проверяем правильность уведомления (письма) менеджерам, о новом сообщении' do
    ActionMailer::Base.deliveries.clear
    talk = talks(:sending_to_shop)
    SellerNotifierMailer.email(talk).deliver_now

    delivery = ActionMailer::Base.deliveries.last
    assert_equal "Новое сообщение на сайте www.test.host от sending1 sending1", delivery.subject
    assert_equal ['robot@example.com'], delivery.to
    assert_equal ['robot@example.com'], delivery.from
    assert_match 'Тут сделать сначала правильное заполнение письма, а потом протестировать', delivery.body.encoded
  end

end
