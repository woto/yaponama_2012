require 'test_helper'

class Admin::BrandsTest < ActionDispatch::IntegrationTest
  
  def setup
    Capybara.reset!
    capybara_sign_in('admin@example.com', '12345678')
  end

  test 'Щелкаем на выпадающем списке "Родительский производитель". Должны быть и неоригиналы' do
    visit "/admin/brands/#{brands(:sending1).id}/edit"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "A.B.S."
  end

  test 'В выпадающем списке производителей мы должно видеть всех. Производителей автомобилей и тех, у кого нет родителей' do
    visit "/admin/brands/new"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "Child 1 Synonym"
    assert has_text? "Child 1 conglomerate"
    assert has_text? "Child 2 conglomerate"
    assert has_text? "Child 2 Slang"
    assert has_text? "Child 1 & Child 2"
  end
end
