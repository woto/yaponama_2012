# encoding: utf-8
#
require 'test_helper'

class TalkLoadOlderTalksTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Если у пользователя менее 2-х сообщений, то ссылка отображаться не должна' do
    skip
  end

end
