require 'test_helper'

class Admin::SpareApplicabilitiesTest < ActionDispatch::IntegrationTest

  test 'Щелкаем на выпадающем списке "Родительский производитель". Должны быть и неоригиналы' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    visit "/admin/spare_applicabilities/#{spare_applicabilities(:sa_1).id}/edit"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "ACURA"
    assert has_no_text? "A.B.S."
  end
end
