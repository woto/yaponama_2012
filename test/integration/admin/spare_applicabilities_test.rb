require 'test_helper'

class Admin::SpareApplicabilitiesTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
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
end
