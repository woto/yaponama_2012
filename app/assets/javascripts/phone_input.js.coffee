# При переключении ckecbox или radio у нас всегда генерируется
# собыбия custom-change в common, тут его ловим, и если это
# переключение маски моб. телефона, то назаначаем соответствующий
# rel, и в mobile_mask уже ставим/убираем маску
$(document).on 'custom-change', "[rel~='checkbox-mobile']", ->

  group = $(this).closest('.input-group')

  if $(this).is(':checked')
    group.find('input[rel|=mobile-mask]').attr('rel', 'mobile-mask-on')
  else
    group.find('input[rel|=mobile-mask]').attr('rel', 'mobile-mask-off')

  $(document).trigger 'update-mobile-mask'
