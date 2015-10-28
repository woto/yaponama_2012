require 'test_helper'

class TalkShowTest < ActionDispatch::IntegrationTest
  def setup
    Rails.configuration.common['display_tawk_to'] = true
  end

  def teardown
    Rails.configuration.common['display_tawk_to'] = false
  end

  test 'Проверка отображения tawk при нажатии на Написать на главной' do
    visit '/'
    sleep 3
    click_link 'Написать'
    within_window(windows.last) do
      assert has_text? 'tawk.to'
    end
    close_popup
  end

  test 'Проверка отображения tawk при нажатии на Задать вопрос на странице товара' do
    visit '/user/products/new?catalog_number=2102'
    sleep 3
    click_link 'Задать вопрос'
    within_window(windows.last) do
      assert has_text? 'tawk.to'
    end
    close_popup
  end

  private

  def close_popup
    main = page.driver.browser.window_handles.first
    popup = page.driver.browser.window_handles.last
    page.driver.browser.switch_to.window(popup)
    page.driver.browser.close
    page.driver.browser.switch_to.window(main)
  end
end
