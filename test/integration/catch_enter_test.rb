# encoding: utf-8
#
require 'test_helper'

class CatchEnterTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'Проверка правильной работы catch enter на просмотра доставки и самовывоза' do
    skip
    # TODO Тут уже не блокируем отправку формы, 
    # т.к. перешло в область Rails form remote: true
    #visit '/deliveries'
    #common
  end

  test 'Проверка правильной работы catch enter при переходе на эту страницу по ссылке (с задействованным turbolinks)' do
    auth('+7 (111) 111-11-11', '1111111111')
    visit '/'
    # turbolinks не работает?
    visit '/admin/deliveries/places/'
    find('#grid-toolbar-new a').click
    common
  end

  test 'Проверка правильной работы catch enter на странице редактирования карт' do
    auth('+7 (111) 111-11-11', '1111111111')
    visit '/admin/deliveries/places/new'
    common
  end

  private 

  def common
    assert has_css? '[rel="catch-enter"]'

    old_url = current_url
    js_code = <<-HERE 
      var e = jQuery.Event("keypress"); 
      e.which = 13; 
      e.keyCode = 13;
      $('[rel="catch-enter"]').trigger(e);
    HERE

    page.execute_script js_code

    assert has_css? '#debug-catch-enter', visible: false, text: 'true'

    # TODO Оказывается посылая этот js Enter Почему-то в действительности не нажимается,
    # хотя событие срабатывает правильно, а вот e.preventDefault() для этого кастомного события
    # становится бесполезным, т.к. submit'a формы почему-то не происходит

    assert_equal old_url, current_url
  end

end
