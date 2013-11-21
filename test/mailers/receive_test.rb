# encoding: utf-8
#
require 'test_helper'

class ReceiveTest < ActionMailer::TestCase
  test "Если письмо содержит неизвестную кодировку, то не должно возникать ошибок. Должна быть koi8-r, по факту koi8_r. К сожалению это письмо от самого Google!" do
    skip
    #assert_raise ArgumentError do
    mail = ReceiveMailer.receive(email_fixture('error.eml'))
    #end
  end

  test "Если письмо приходит от неизвестного адреса, то должен создасться пользователь и привязанный к нему профиль с почтовым адресом и именем взятым из письма. А так же у этого пользователя создастся talk запись связанная с этим письмом." do
    mail = ReceiveMailer.receive(email_fixture('39.eml'))
    assert_equal User.last.profiles.first.emails.first.value, "oganer@gmail.com"
    assert_equal User.last.profiles.first.names.first.name, "Корнев Руслан"
    assert_equal User.last.talks.last.talkable.subject, "Тестирование вложений" 
  end

  test "Если письмо приходит от адреса, закрепленного за пользователем, то письмо попадает в talk к нему. Имя в соответствующем профиле не обновляется, т.к. такой адрес уже был" do

    assert_no_difference "emails(:first_user).profile.names.count" do
      assert_difference "somebodies(:first_user).talks.count" do
        mail = ReceiveMailer.receive(email_fixture('40.eml'))
      end
    end
  end

end
