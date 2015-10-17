require 'test_helper'

class Admin::SpareApplicabilitiesTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
    capybara_sign_in('admin@example.com', '12345678')
  end

  test 'Проверяем работу автозаполнения по каталожному номеру' do
    visit new_admin_spare_applicability_path
    execute_script %q($("input[rel='select2-spare_info']").select2('open'))
    find("input.select2-input").set('2102')
    execute_script %q($("input.select2-input").trigger('change'))
    assert has_text? "2102 (NISSAN)"
  end

  test 'Щелкаем на выпадающем списке. Неоригиналы видимы быть не должны' do
    visit "/admin/spare_applicabilities/#{spare_applicabilities(:sa_1).id}/edit"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    execute_script %q($("input.select2-input").trigger('change'))
    assert has_text? "ACURA"
    assert has_no_text? "A.B.S."
  end

  test 'Похожий на предыдущий тест. Проверяем, что видим только is_brand' do
    visit "/user/cars/new"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_no_text? "Child 1 Synonym"
    assert has_text? "Child 1 conglomerate"
    assert has_text? "Child 2 conglomerate"
    assert has_no_text? "Child 2 Slang"
    assert has_no_text? "Child 1 & Child 2"
  end
end
