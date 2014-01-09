$(document).on 'custom-change', "input[rel~='radio-new-old-switcher']", ->
  # TODO Оставлю рефакторинг до исправления ошибки с change event у twbs themed radio button

  block = $(this).closest("[rel~='type-store']")

  radio = ['new', 'old']

  if $(this).is(':checked')
    if  $(this).val() == 'new'
      opposite = 'old'
    else
      opposite = 'new'
  else
    if  $(this).val() == 'old'
      opposite = 'old'
    else
      opposite = 'new'

  cur = block.find("[rel~='" + $(this).val() + "']")
  opp = block.find("[rel~='" + opposite + "']")

  cur.show()
  opp.hide()

  cur.find(":input").prop("disabled", false);
  opp.find(":input").prop("disabled", true);
