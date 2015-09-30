require 'test_helper'

class Admin::SpareInfosTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Щелкаем на выпадающем списке "Родительский производитель". Должны быть и неоригиналы' do
    Capybara.reset!
    visit "/admin/spare_infos/new"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "A.B.S."
  end

  test 'Похожий на предыдущий тест. Проверяем, что видим только brand: nil, sign: nil' do
    visit "/admin/spare_infos/new"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_no_text? "Child 1 Synonym"
    assert has_no_text? "Child 1 conglomerate"
    assert has_no_text? "Child 2 conglomerate"
    assert has_no_text? "Child 2 Slang"
    assert has_text? "Child 1 & Child 2"
  end
end
