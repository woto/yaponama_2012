# При смены платежной системы
$(document).on 'custom-change', '[name="payment[payment_type]"]', ->
  # Если выделена эта платежная система
  if $(this).prop('checked')
    # Мы скрываем все блоки (адрес или профиль и т.д.)
    $('.payment-block').hide()
    # И делаем все их элементы отключенными
    $('.payment-block').find(":input").prop("disabled", true);
    # Получаем из data видимые блоки
    for block in $(this).data().blocks
      # Находим этот блок и отображаем
      $("#" + block).show()
      # А так же включаем элемент выбора checkbox Новый или Выбрать из имеющихся и генерируем событие custom-change для него
      $("#" + block).find("[rel~='radio-new-old-switcher']:input").prop("disabled", false).trigger('custom-change')


$(document).on 'custom-change', '[rel~="select-and-fill"]', ->

  type_store = $(this).closest('[rel~="type-store"]')

  type_store.find('.select-and-fill').hide()
  type_store.find('.select-and-fill').find(":input").prop("disabled", true);

  type_store.find('#select-and-fill-' + $(this).val()).show()
  type_store.find('#select-and-fill-' + $(this).val()).find(":input").prop("disabled", false);


$(document).on 'change', '[name~="payment[payment_type]"]', ->
  $("html, body").animate({scrollTop: $('#payment-details').offset().top}, 'fast')
