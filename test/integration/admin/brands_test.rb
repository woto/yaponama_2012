require 'test_helper'

class Admin::BrandsTest < ActionDispatch::IntegrationTest

  test 'Щелкаем на выпадающем списке "Родительский производитель". Должны быть и неоригиналы' do
    Capybara.reset!
    visit "/admin/brands/#{brands(:sending1).id}/edit"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "A.B.S."
  end
end
