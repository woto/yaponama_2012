format = (data) -> 
  #if (!state.id) return state.text; // optgroup
  #"<img class='flag' src='" + data.thumb + "'/>" + data.text;
  if data.new?
    "Создать: " + data.text.toString().toUpperCase()
  else
    data.text

format_z = (data) ->
  data.text.toString().toUpperCase()

$ ->
  initSelect2()

$(document).on 'page:load', ->
  initSelect2()

$(document).on 'cocoon:after-insert', '#cars', ->
  initSelect2()

initSelect2 = ->
  console

  $("#cars > .nested-fields").each (idx, scope) -> 

    brand = undefined
    $(scope).find("input[id$='marka']").each (idx, el) ->
      brand = el

    model = undefined
    $(scope).find("input[id$='model']").each (idx, el) ->
      model = el



    # BRAND
    $(brand).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      formatResult: format
      formatSelection: format_z
      #minimumInputLength: 1
      query: (options) ->

        params = 
          page: options.page
          name: options.term

        zzz = undefined
        zzz = results: []

        unless options.context? 
          if options.page <= 1
            if options.term? && options.term.length > 0
              zzz.results.push
                id: options.term
                text: options.term
                new: true

        $.getJSON "/admin/brands/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name


          if data.length
            zzz.more = true

          options.callback zzz

    $(brand).on 'change', ->
      if $(model).select2("val") != ""
        $(model).select2("val", "")

    # MODEL
    $(model).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      custom: brand
      formatResult: format
      formatSelection: format_z
      query: (options) ->

        params =
          page: options.page
          name: options.term
          brand: $(brand).select2('val')

        zzz = undefined
        zzz = results: []

        unless options.context?
          if options.page <= 1
            if options.term? && options.term.length > 0
              zzz.results.push
                id: options.term
                text: options.term
                new: true

        $.getJSON "/admin/models/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name

          if data.length
            zzz.more = true

          options.callback zzz
