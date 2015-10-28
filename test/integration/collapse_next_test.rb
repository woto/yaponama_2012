require 'test_helper'

class CollapseNextTest < ActionDispatch::IntegrationTest

  test 'collapse-next для checkbox' do
    visit '/categories/333564447-batareya-akkumulyatornaya'
    assert has_no_text? 'Норильская'
    find('label', text: 'Наличие в магазине').click
    assert has_text? 'Норильская'
  end

  test 'collapse-next для range' do
    visit '/categories/333564447-batareya-akkumulyatornaya'
    assert has_no_css? '#q_accumulator_battery_capacity_gt'
    find('label', text: 'Емкость').click
    assert has_css? '#q_accumulator_battery_capacity_gt'
  end

end
