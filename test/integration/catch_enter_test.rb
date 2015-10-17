require 'test_helper'

class CatchEnterTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
    capybara_sign_in('admin@example.com', '12345678')
  end

  test 'Проверка правильной работы catch enter на странице редактирования карт' do
    visit '/admin/deliveries/places/new'
    assert has_css? '[catch-enter]'

    old_url = current_url
    js_code = <<-HERE 
      var e = jQuery.Event("keypress"); 
      e.which = 13; 
      e.keyCode = 13;
      $('[catch-enter]').trigger(e);
    HERE

    page.execute_script js_code

    assert has_css? '#XXX', visible: false, text: 'true'

    # TODO Оказывается посылая этот js Enter Почему-то в действительности не нажимается,
    # хотя событие срабатывает правильно, а вот e.preventDefault() для этого кастомного события
    # становится бесполезным, т.к. submit'a формы почему-то не происходит

    assert_equal old_url, current_url
  end

end
