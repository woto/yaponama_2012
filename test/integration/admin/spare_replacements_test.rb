require 'test_helper'

class Admin::SpareApplicabilitiesTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
    capybara_sign_in('admin@example.com', '12345678')
  end

  test 'Проверяем работу автозаполнения from_spare_info' do
    visit new_admin_spare_replacement_path
    execute_script %q($("input[rel='select2-from_spare_info']").select2('open'))
    find("input.select2-input").set('2102')
    execute_script %q($("input.select2-input").trigger('change'))
    assert has_text? "2102 (NISSAN)"
  end

  test 'Проверяем работу автозаполнения to_spare_info' do
    visit new_admin_spare_replacement_path
    execute_script %q($("input[rel='select2-to_spare_info']").select2('open'))
    find("input.select2-input").set('2102')
    execute_script %q($("input.select2-input").trigger('change'))
    assert has_text? "2102 (NISSAN)"
  end
end
