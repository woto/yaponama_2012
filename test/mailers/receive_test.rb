# encoding: utf-8

require 'test_helper'

class ReceiveTest < ActionMailer::TestCase
  test "Если письмо содержит неизвестную кодировку, то возникает ошибка. Должна быть koi8-r, по факту koi8_r. К сожалению это письмо от самого Google!" do
    assert_raise ArgumentError do
      mail = ReceiveMailer.receive(email_fixture('error.eml'))
    end
  end
end
