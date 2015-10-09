require 'test_helper'

class User::CartTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation

  def setup
    Capybara.reset!
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  test 'Если мы пытаемся нажать на минус у товара в 1 экземпляре, то появляется окошко с подтверждением' do
    capybara_sign_in('user@example.com', '12345678')
    visit user_cart_index_path
    find('#minus_product_445071774').click
    assert has_text? 'Действительно хотите удалить'
  end

  test 'Если нажимаем отрицательно в окне подтверждения удаления, то товар не удаляется' do
    capybara_sign_in('user@example.com', '12345678')
    visit user_cart_index_path
    find('#minus_product_445071774').click
    click_button 'Отмена'
    assert has_css? '#row_product_445071774'
  end

  test 'Если нажимаем утвердительно в окне подтверждения удаления, то товар удаляется' do
    capybara_sign_in('user@example.com', '12345678')
    visit user_cart_index_path
    find('#minus_product_445071774').click
    click_button 'Применить'
    assert has_no_css? '#row_product_445071774'
  end

  test 'Когда нажимаем минус у товара в 2 и более экземлпярах, то меняется количество в input' do
    capybara_sign_in('user@example.com', '12345678')
    visit user_cart_index_path
    assert has_field? 'count_product_59641890', with: '2'
    find('#minus_product_59641890').click
    assert has_field? 'count_product_59641890', with: '1'
  end

  test 'Когда нажимаем плюс у товара, то меняется количество в input' do
    capybara_sign_in('user@example.com', '12345678')
    visit user_cart_index_path
    assert has_field? 'count_product_445071774', with: '1'
    find('#plus_product_445071774').click
    assert has_field? 'count_product_445071774', with: '2'
  end

end
