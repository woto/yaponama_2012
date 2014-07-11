# encoding: utf-8
#
require 'test_helper'

class TalkAttentionTest < ActionDispatch::IntegrationTest

  test 'После написания сообщения гостем, который указал email и телефон должна показаться attention с просьбой подтверждения' do
    Capybara.reset!
    visit '/'
    fill_in 'talk[somebody_attributes][profile_attributes][names_attributes][0][name]', with: 'Мокшузь'
    fill_in 'talk[somebody_attributes][profile_attributes][emails_attributes][0][value]', with: 'dormds@ivme.ie'
    page.execute_script "$('[name=\"talk[somebody_attributes][profile_attributes][phones_attributes][0][value]\"]').val('+7 (482) 039-28-31')"
    fill_in 'talk[text]', with: 'Текст сообщения 384592348950205829539'
    click_button 'talk-submit'
    assert has_text? 'Пожалуйста, подтвердите e-mail адрес dormds@ivme.ie'
    assert has_text? 'Пожалуйста, подтвердите номер мобильного телефона +7 (482) 039-28-31'
  end

end
