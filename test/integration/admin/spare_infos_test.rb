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
end
