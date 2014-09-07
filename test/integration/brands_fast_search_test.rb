require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test 'По-умолчанию мы не видим бренд TOYOTA' do
    visit '/'
    assert has_no_text? 'TOYOTA'
  end

  test 'Если мы пишем букву T, то должны увидеть TOYOTA' do
    visit '/'
    fill_in 'name', with: 'T'
    assert has_text? 'TOYOTA'
  end

  test 'Если мы что-то написали, а потом очистили, то мы увидим AUDI' do
    visit '/'
    fill_in 'name', with: '123'
    fill_in 'name', with: ''
    assert has_text? 'AUDI'
  end

end

