# encoding: utf-8
#
require 'test_helper'

class TalkSomebodyTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset!
  end

  test 'Пользователь пишет сообщение. Somebody должен быть этим пользователем' do
    otto = somebodies(:otto)
    auth('+7 (555) 555-55-55', '5555555555')
    #visit '/'
    click_link 'talk-button-show-inside'

    fill_talk 'Пользователь пишет селлеру'

    click_button 'talk-submit'

    sleep 1
    assert_equal Talk.last.somebody, otto
  end

  test 'Селлер пишет сообщение в области пользователя. Somebody должен быть этим пользователем ' do
    otto = somebodies(:otto)
    auth('+7 (111) 111-11-11', '1111111111')
    visit "/admin/users/#{otto.id}"
    click_link 'talk-button-show-inside'

    fill_talk 'Селлер написал пользователю'

    click_button 'talk-submit'

    sleep 1
    assert_equal Talk.last.somebody, otto
  end
end
