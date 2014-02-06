$(document).on 'custom-change', "input[rel~='radio-new-old-switcher']", ->

  if $(this).is(':checked')

    block = $(this).closest("[rel~='type-store']")

    cur = $(this).val()
    opp = if cur == 'new' then 'old' else 'new'

    cur_block = block.find("[rel~='"+cur+"']")
    opp_block = block.find("[rel~='"+opp+"']")

    cur_block.show()
    opp_block.hide()

    #opp_block.find(':input').prop("disabled", true)

    if cur == 'new'
      #cur_block.find(':input').prop("disabled", false)
    else
      #cur_block.find("[rel~=select-and-fill]:input").prop("disabled", false).trigger('custom-change')
      cur_block.find("[rel~=select-and-fill]:input").trigger('custom-change')

      ## Отключаем все элементы в текущем блоке
      #block.find("[rel~='"+cur+"']")

      #block.find(':input').prop("disabled", true)

      ## Кроме checkbox переключающего new и old
      #block.find("[rel~='radio-new-old-switcher']").prop("disabled", false)
