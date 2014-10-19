require 'test_helper'

class BuyerNotifierMailerTest < ActionMailer::TestCase

  test 'Проверяем правильность письма пользователю, о новом сообщении' do
    ActionMailer::Base.deliveries.clear
    talk = talks(:sending_from_shop)
    BuyerNotifierMailer.email(talk, 'asfkjh@dfafdjka.ru').deliver_now

    delivery = ActionMailer::Base.deliveries.last
    assert_equal "Новое сообщение на сайте www.test.host", delivery.subject
    assert_equal ['asfkjh@dfafdjka.ru'], delivery.to
    assert_equal ['info@avtorif.ru'], delivery.from
    assert_match 'Тут сделать сначала правильное заполнение письма, а потом протестировать', delivery.body.encoded
  end

  test 'Проверяем правильность смс пользователю, о новом сообщении' do
    ActionMailer::Base.deliveries.clear
    talk = talks(:sending_from_shop)

    BuyerNotifierMailer.phone(talk, '+71234567890').deliver_now

    delivery = ActionMailer::Base.deliveries.last
    assert_equal "+71234567890", delivery.subject
    assert_equal ['b049fb236f62a7f78166@avisosms.ru'], delivery.to
    assert_equal ['info@avtorif.ru'], delivery.from
    assert_match 'Тут сделать сначала правильное заполнение письма, а потом протестировать', delivery.body.encoded
  end

end
