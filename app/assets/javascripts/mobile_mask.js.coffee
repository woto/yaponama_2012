$(document).on 'update-mobile-mask', ->
  $("[rel~=mobile-mask-on]").mask("+7 (999) 999-99-99")
  $("[rel~=mobile-mask-off]").unmask()

$ ->
  $(document).trigger 'update-mobile-mask'
